//
//  FestivalCache.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/25.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation

class FestivalIdCache {
    
    var cache = NSCache<NSString, NSNumber>()
    
    func get(forKey: String) -> NSNumber? {
        return cache.object(forKey: NSString(string:forKey))
    }
    
    func set(forKey: String, id: Int) {
        cache.setObject(NSNumber(value: id), forKey: NSString(string: forKey))
    }
}

extension FestivalIdCache {
    
    private static var festivalIdCache = FestivalIdCache()
    static func getFestivalIdCache() -> FestivalIdCache {
        return festivalIdCache
    }
}
