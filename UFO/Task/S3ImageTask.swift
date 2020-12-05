//
//  S3ImageTask.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/12/04.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation
import UIKit
import S3
import NIO
import Alamofire

class S3ImageTask: ObservableObject {
    
    let imageCache = ImageCache.getImageCache()
    
    var image: UIImage? = nil {
        
        didSet {
            objectWillChange.send()
        }
    }
    
    func loadImage(forKey: String) {
        
        if loadImageFromCache(forKey: forKey) {

            let log = String(describing: self) + "." + #function + " : Cache Hit"
            NSLog(log)

            return
        }

        let log = String(describing: self) + "." + #function + " : Cache Miss"
        NSLog(log)

        loadImageFromS3(forKey: forKey)
        
    }
    
    private func loadImageFromCache(forKey: String) -> Bool {
        
        guard let cacheImage = self.imageCache.get(forKey: forKey) else {
            return false
        }
        
        image = cacheImage
        
        return true
    }
    
    private func loadImageFromS3(forKey: String) {
        
        let baseURL = Bundle.main.infoDictionary!["BaseURL"] as! String
        guard let url = URL(string: baseURL + "/awsCredential") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = .useProtocolCachePolicy
        request.setValue("private, max-age=30", forHTTPHeaderField: "Cache-Control")
        
        AF.request(request).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                
                if let jsonObj = value as? Dictionary<String, String> {
                    
                    let accessKeyId = jsonObj["accessKeyId"]!
                    let secretAccessKey = jsonObj["secretAccessKey"]!
                    let region = jsonObj["region"]!
                    
                    let s3 = S3(accessKeyId: accessKeyId, secretAccessKey: secretAccessKey, region: Region(rawValue: region))
                    let getObjectReqeust = S3.GetObjectRequest(bucket: "ufo-image", key: forKey)
                    let output = s3.getObject(getObjectReqeust)
                    
                    output.whenSuccess({ response in
                        let img = UIImage(data: response.body!)
                        
                        self.imageCache.set(forKey: forKey, image: img!)
                        
                        DispatchQueue.main.async {
                            self.image = img
                        }
                    })
                    
                    output.whenFailure({ error in
                        
                        print(error)
                    })
                }
                
            case .failure(let error):
                print("error: \(String(describing: error.errorDescription))")
            }

        }
    }
    
}
