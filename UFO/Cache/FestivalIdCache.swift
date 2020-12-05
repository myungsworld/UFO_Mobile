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
    var fileManager: FileManager
    var cachePath: URL
    var filePath: URL
    
    init() {
        self.fileManager = FileManager.default
        self.cachePath = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        self.filePath = cachePath.appendingPathComponent("festival_id")
    }
    
    func getFestivalId() -> Int {
        
        // When can't hit by "festival_id"
        guard let festival_id = self.getCache(forKey: "festival_id") else {
            
            // Check if exist "festival_id" in file
            // file doesn't exist
            if !self.fileExist() {
                // show pop up menu
                return -1
            } else {
            // file exist
                let festival_id = self.getFile()
                self.setCache(forKey: "festival_id", value: festival_id)
                return festival_id
            }
        }
        // When success to hit
        // type: NSNumber
        return Int(truncating: festival_id)
    }
    
    func setFetivalId(festival_id: Int) {
        
        self.setCache(forKey: "festival_id", value: festival_id)
        self.setFile(value: String(festival_id))
        
    }
    
    private func getCache(forKey: String) -> NSNumber? {
        
        let value =  cache.object(forKey: NSString(string:forKey))
        
        if value == nil {
            let log = String(describing: self) + "." + #function + " : Cache Miss"
            NSLog(log)
        } else {
            let log = String(describing: self) + "." + #function + " : Cache Hit"
            NSLog(log)
        }
        
        return value
    }
    
    private func setCache(forKey: String, value: Int) {
        cache.setObject(NSNumber(value: value), forKey: NSString(string: forKey))
    }
    
    private func getFile() -> Int {
        
        do {
            let result = try String(contentsOf: self.filePath, encoding: .utf8)
            
            return Int(result)!
        } catch let e {
            print("festival_id: getFile()", e.localizedDescription)
            
            return -1
        }
    }
    
    private func setFile(value: String) {
        
        do {
            let text = NSString(string: value)
            
            try text.write(to: self.filePath, atomically: true, encoding: String.Encoding.utf8.rawValue)
        } catch let e {
            print("festival_id: setFile()", e.localizedDescription)
        }
    }
    
    func removeFile() {
        do {
            try self.fileManager.removeItem(at: self.filePath)
        } catch let e {
            print("festival_id: removeFile()", e.localizedDescription)
        }
    }
    
    func fileExist() -> Bool {
        
        let isExisted = self.fileManager.fileExists(atPath: self.filePath.path)
        
        if isExisted {
            let log = String(describing: self) + "." + #function + " : FileCache Exists"
            NSLog(log)
        } else {
            let log = String(describing: self) + "." + #function + " : FileCache doesn't exists"
            NSLog(log)
        }
        
        
        return isExisted
    }
}

extension FestivalIdCache {
    
    private static var festivalIdCache = FestivalIdCache()
    static func getFestivalIdCache() -> FestivalIdCache {
        return festivalIdCache
    }
}
