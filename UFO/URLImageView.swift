//
//  URLImageView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/12/06.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct URLImageView: View {
    
    @ObservedObject var urlImageTask: URLImageTask
    var width: CGFloat
    var height: CGFloat
    
    init(url: String, width: CGFloat, height: CGFloat) {
        self.urlImageTask = URLImageTask()
        self.width = width
        self.height = height
        
        self.urlImageTask.loadImage(url: url)
    }
    
    var body: some View {
        Image(uiImage: self.urlImageTask.image ?? URLImageView.defaultImage!)
            .resizable()
            .scaledToFit()
            .frame(width: self.width, height: self.height)
    }
    
    static var defaultImage = UIImage(systemName: "lock")
}
