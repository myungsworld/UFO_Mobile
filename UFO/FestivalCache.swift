//
//  FestivalCache.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/11/26.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation

class FestivalCache {
    
    var festival_id: String = ""
    var cache = NSCache<NSString, FestivalData>()
    var fileManager: FileManager
    var cachePath: URL
    var filePath: URL
    
    init() {
        self.fileManager = FileManager.default
        self.cachePath = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    }
    
    func getFestival() {
//        guard let festival = self.getCache(self.festival_id) else {
//
//
//        }
        
    }
    
    func setFestival(festivalData: FestivalData) {
        self.festival_id = festivalData.festival_id
        self.filePath = cachePath.appendingPathComponent(festival_id)
        
        let dicType: Dictionary<String, String> = [
            "festival_id": festivalData.festival_id,
            "name": festivalData.name,
            "img_url": festivalData.img_url,
            "start_time": festivalData.start_date,
            "end_time": festivalData.end_date,
            "latitude": festivalData.latitude,
            "longitude": festivalData.longitude,
            "desc": festivalData.desc
        ]
        
        self.setFile(dicType)
        
    }
    
    func removeFromFile() {
        
    }
    
    private func getCache(forKey: String) -> FestivalData? {
        return cache.object(forKey: NSString(string: self.festival_id))
    }
    
    private func setCache(forKey: String, value: FestivalData) {
        cache.setObject(value, forKey: NSString(string: forKey))
    }
    
    private func getFile() {
        
        do {
            let result = try String(contentsOf: self.filePath, encoding: .utf8)
            
            print(result)
        } catch let e {
            print("festival: getFile()", e.localizedDescription)
        }
    }
    
    private func setFile(_ value: Dictionary<String, String>) {
        
        do {
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: value, options: []) {
                let jsonText = String(data: jsonData, encoding: .ascii)
                
                let text = NSString(string: jsonText!)

                try text.write(to: self.filePath, atomically: true, encoding: String.Encoding.utf8.rawValue)
            }
        } catch let e {
            print("festivla: setFile()", e.localizedDescription)
        }
    }
 
    
}

extension FestivalCache {
    private static var festivalCache = FestivalCache()
    static func getFesticalCache() -> FestivalCache {
        return festivalCache
    }
    
}
