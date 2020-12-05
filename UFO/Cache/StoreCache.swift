//
//  StoreCache.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/12/01.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation

class StoreCache {
    
    var cache = NSCache<NSString, StoreData>()
    
    func getCache(forKey: String) -> StoreData! {
        
        let key = "s-\(forKey)"
        
        let value =  cache.object(forKey: NSString(string: key))
        
        if value == nil {
            let log = String(describing: self) + "." + #function + " : Cache Miss"
            NSLog(log)
        } else {
            let log = String(describing: self) + "." + #function + " : Cache Hit"
            NSLog(log)
        }
        
        return value
    }
    
    func setCache(forKey: String, value: StoreData) {
        
        let key = "s-\(forKey)"
        cache.setObject(value, forKey: NSString(string: key))
    }
}

extension StoreCache {
    private static var storeCache = StoreCache()
    static func getStoreCache() -> StoreCache {
        return storeCache
    }
}
