//
//  ETagCache.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/11/28.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation

class ETagCache {
    
    var cache = NSCache<NSString, NSString>()
    var fileManager: FileManager
    
    init() {
        self.fileManager = FileManager.default
    }
    
    func getEtag(forKey: String) -> String {
        
        guard let etag = self.getCache(forKey: forKey) else {
            print("etag: getEtag(): Cache Miss")
            
            if !self.fileExist(forKey: forKey) {
                print("etag: getEtag(): no etag in file")
                
                return "fail"
            } else {
                let etag = self.getFile(forKey: forKey)
                print("etag: getFile(): In the File")
                
                self.setCache(forKey: forKey, value: etag)
                
                return etag
            }
        }
        
        print("etag: getEtag(): Cache Hit!")
        return "ASD"
    }
    
    func setETag(forKey: String, value: String) {
        self.setCache(forKey: forKey, value: value)
        self.setFile(forKey: forKey, value: value)
        
    }
    
    func removeFromFile(forKey: String) {
        let cachePath = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let filePath = cachePath.appendingPathComponent(forKey)
        
        do {
            try self.fileManager.removeItem(at: filePath)
        } catch let e {
            print("etag: removeFromFile():", e.localizedDescription)
        }
        
    }
    
    private func getCache(forKey: String) -> NSString? {
        
        return cache.object(forKey: NSString(string: forKey))
        
    }
    
    private func setCache(forKey: String, value: String) {
        cache.setObject(NSString(string: value), forKey: NSString(string: forKey))
        
    }
    
    private func getFile(forKey: String) -> String {
        let cachePath = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let filePath = cachePath.appendingPathComponent(forKey)
        
        do {
            let result = try String(contentsOf: filePath, encoding: .utf8)
            
            return result
        } catch let e {
            print("etag: getFile()", e.localizedDescription)
            return "fail"
        }
    }
    
    private func setFile(forKey: String, value: String) {
        
        let cachePath = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let filePath = cachePath.appendingPathComponent(forKey)
        
        do {
            let text = NSString(string: value)
            try text.write(to: filePath, atomically: true, encoding: String.Encoding.utf8.rawValue)
        } catch let e {
            print("etag: setFile()", e.localizedDescription)
        }
    }
    
    private func fileExist(forKey: String) -> Bool {
        let cachePath = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let filePath = cachePath.appendingPathComponent(forKey)
        
        return self.fileManager.fileExists(atPath: filePath.path)
    }
}

extension ETagCache {
    private static var etagCache = ETagCache()
    static func getEtagCache() -> ETagCache {
        return etagCache
    }
}
