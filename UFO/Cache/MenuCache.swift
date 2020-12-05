//
//  MenuCache.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/12/01.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation

class MenuCache {
    
    var cache = NSCache<NSString, NSArray>()
    
    func getCache(forKey: String) -> [MenuData]! {
        
        let key = "m-\(forKey)"
        
        let value = cache.object(forKey: NSString(string: key)) as? [MenuData]
        
        if value == nil {
            let log = String(describing: self) + "." + #function + " : Cache Miss"
            NSLog(log)
        } else {
            let log = String(describing: self) + "." + #function + " : Cache Hit"
            NSLog(log)
        }
        
        return value

    }
    
    func setCache(forKey: String, value: [MenuData]) {
        
        let key = "m-\(forKey)"
        let newVal = value as NSArray
        cache.setObject(newVal, forKey: NSString(string: key))
    }
    
}

extension MenuCache {
    private static var menuCache = MenuCache()
    static func getMenuCache() -> MenuCache {
        return menuCache
    }
}
