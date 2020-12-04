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

class S3ImageTask: ObservableObject {
    
    let imageCache = ImageCache.getImageCache()
    
    private let s3 = S3(accessKeyId: "AKIA4CH2SWRA7THUO25O", secretAccessKey: "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",  region: Region(rawValue: "ap-northeast-2"))
    
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
        //"5EFADC67-A4C8-43A8-BF19-CB621D8C8FF3.jpeg"
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
        
        let getObjectReqeust = S3.GetObjectRequest(bucket: "ufo-image", key: forKey)
        let output = s3.getObject(getObjectReqeust)
        
        output.whenSuccess({ response in
            let img = UIImage(data: response.body!)
            
            self.imageCache.set(forKey: forKey, image: img!)
            self.image = img
            
        })
        
        output.whenFailure({ error in
            
            print(error)            
        })
    }
    
}
