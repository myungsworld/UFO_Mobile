//
//  AWSTask.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/12/04.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation
import S3
import NIO
import UIKit

class AWSTask {
    
    let imageCache = ImageCache.getImageCache()

    
    func getBucketList() {
        let futureOutput = s3.listBuckets()
        
        let tmp = S3.GetBucketAclRequest(bucket: "ufo-image")
        let future = s3.getBucketAcl(tmp)
        
        future.whenSuccess({ response in
            print(response)
        })
        
        future.whenFailure({ error in
            print(error)
        })
    }
    
    func downloadImage() {
        let getObjectReqeust = S3.GetObjectRequest(bucket: "ufo-image", key: "5EFADC67-A4C8-43A8-BF19-CB621D8C8FF3.jpeg")
        
        let output = s3.getObject(getObjectReqeust)
        
        output.whenSuccess({ response in
            
            let img = UIImage(data: response.body!)
            
            self.imageCache.set(forKey: "test", image: img!)
            
            
            print(response)
        })
        
        output.whenFailure({ error in
            
            print(error)
            
        })
        
        
    }
    
    func uploadImage(_ image: UIImage, completion: @escaping (String?) -> ()) {
        
        guard let imageData = image.jpegData(compressionQuality: 1) else {
            completion(nil)
            return
        }
        
        let uuid = UUID().uuidString
        let fileName = "\(uuid).jpeg"
        
        let putObjectRequest = S3.PutObjectRequest(body: imageData, bucket: "ufo-image", contentLength: Int64(imageData.count), key: fileName)
        
        let futureOutput = s3.putObject(putObjectRequest)
        
        futureOutput.whenSuccess({ response in
            print(response)
            completion(fileName)
        })
        
        futureOutput.whenFailure({ error in
            print(error)
            completion(nil)
        })
        
        
    }
    
}
