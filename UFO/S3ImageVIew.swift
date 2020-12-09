//
//  S3ImageVIew.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/12/04.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct S3ImageVIew: View {
    
    @ObservedObject var s3ImageTask: S3ImageTask
    
    init(img_url: String) {
        self.s3ImageTask = S3ImageTask()
        
        self.s3ImageTask.loadImage(forKey: img_url)
        
    }
    
    var body: some View {
        Image(uiImage: self.s3ImageTask.image ?? S3ImageVIew.defaultImage!)
            .resizable()
    }
    
    static var defaultImage = UIImage(systemName: "lock")
}
