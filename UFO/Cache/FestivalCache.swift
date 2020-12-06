//
//  FestivalCache.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/11/26.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation

class FestivalCache {

    var cache = NSCache<NSString, FestivalData>()

    func getCache(forKey: String) -> FestivalData! {
        
        let key = "f-\(forKey)"
        
        let value = cache.object(forKey: NSString(string: key))
        
        if value == nil {
            let log = String(describing: self) + "." + #function + " : Cache Miss"
            NSLog(log)
        } else {
            let log = String(describing: self) + "." + #function + " : Cache Hit"
            NSLog(log)
        }
        
        return value
    }
    
    func setCache(forKey: String, value: FestivalData) {
        
        let key = "f-\(forKey)"        
        cache.setObject(value, forKey: NSString(string: key))
    }
}

extension FestivalCache {
    private static var festivalCache = FestivalCache()
    static func getFesticalCache() -> FestivalCache {
        return festivalCache
    }
}
