//
//  URLImageView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/21.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct URLImageView: View {
    
    @ObservedObject var urlImageModel: URLImageModel

    init(urlString: String?) {
        urlImageModel = URLImageModel(urlString: urlString)
        urlImageModel.loadImage()
    }
    
    var body: some View {
        
        Image(uiImage: urlImageModel.image ?? URLImageView.defaultImage!)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
        
    }
    
    static var defaultImage = UIImage(systemName: "lock")
}

struct URLImageView_Previews: PreviewProvider {
    static var previews: some View {
        URLImageView(urlString: "")
    }
}
