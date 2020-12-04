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
    var width: CGFloat
    var height: CGFloat
    
    init(img_url: String, width: CGFloat, height: CGFloat) {
        self.s3ImageTask = S3ImageTask()
        self.width = width
        self.height = height
        
        self.s3ImageTask.loadImage(forKey: img_url)
        
    }
    
    var body: some View {
        Image(uiImage: self.s3ImageTask.image ?? S3ImageVIew.defaultImage!)
            .resizable()
            .scaledToFit()
            .frame(width: self.width, height: self.height)
    }
    
    static var defaultImage = UIImage(systemName: "lock")
}
