//
//  URLImageTask.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/12/06.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class URLImageTask: ObservableObject {
    
    let imageCache = ImageCache.getImageCache()
    
    var image: UIImage? = nil {
        didSet {
            objectWillChange.send()
        }
    }
    
    func loadImage(url: String) {
        
        if loadImageFromCache(url: url) {
            
            let log = String(describing: self) + "." + #function + " : Cache Hit"
            NSLog(log)

            return
        }
        
        let log = String(describing: self) + "." + #function + " : Cache Miss"
        NSLog(log)
        
        loadImageFromURL(url: url)
        
    }
    
    private func loadImageFromCache(url: String) -> Bool {
        
        guard let cacheImage = self.imageCache.get(forKey: url) else {
            return false
        }
        
        image = cacheImage
        
        return true
    }

    private func loadImageFromURL(url: String) {
        
        guard let _url = URL(string: url) else { return }
        
        var request = URLRequest(url: _url)
        request.httpMethod = "GET"
        request.cachePolicy = .useProtocolCachePolicy
        request.setValue("private, max-age=30", forHTTPHeaderField: "Cache-Control")
        
        AF.request(request).responseData { response in
            
            switch response.result {
            case .success(let data):
                
                let img = UIImage(data: data)!
                
                self.imageCache.set(forKey: url, image: img)
                DispatchQueue.main.async {
                    self.image = img
                }
                
            case .failure(let error):
                print("error: \(String(describing: error.errorDescription))")
            }
            
        }
    }
}
