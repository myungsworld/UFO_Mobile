//
//  ImageCache.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/21.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation
import SwiftUI

class ImageCache {
    
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
    
}

extension ImageCache {
    
    private static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache {
        return imageCache
    }
    
}
