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
            
            print("festival_id: getCache() Cache Miss")
            
            // Check if exist "festival_id" in file
            // file doesn't exist
            if !self.fileExist() {
                print("festival_id: fileExist() no festival_id file")
                
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
        return Int(festival_id)
    }
    
    func setFetivalId(festival_id: Int) {
        
        self.setCache(forKey: "festival_id", value: festival_id)
        self.setFile(value: String(festival_id))
    }
    
    // should add removeCache
    
    func removeFile() {
        do {
            try self.fileManager.removeItem(at: self.filePath)
        } catch let e {
            print("festival_id: removeFile()", e.localizedDescription)
        }
    }
    
    private func getCache(forKey: String) -> NSNumber? {
        return cache.object(forKey: NSString(string:forKey))
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
    
    
    
    private func fileExist() -> Bool {
        return self.fileManager.fileExists(atPath: self.filePath.path)
    }
}

extension FestivalIdCache {
    
    private static var festivalIdCache = FestivalIdCache()
    static func getFestivalIdCache() -> FestivalIdCache {
        return festivalIdCache
    }
}
