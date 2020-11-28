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
    var fileManager: FileManager

    init() {
        self.fileManager = FileManager.default
        
    }
    
    func getFestival(forKey: String) -> FestivalData? {
        
        guard let festivalData = self.getCache(forKey: forKey) else {
            print("festivalData: getCache(): Cache Miss")
            
            if !self.fileExist(forKey: forKey) {
                print("festivalData: fileExist(): no festivalData file")
                
                
                return nil
            } else {
                let festivalData = self.getFile(forKey: forKey)
                
                print("festivalData: getFile(): In the File")
                
                self.setCache(forKey: forKey, value: festivalData!)
                
                return festivalData
            }
        }
        
        print("festivalData: getCache(): Hit!")
        
        return festivalData
    }
    
    func setFestival(festivalData: FestivalData) {
        
        // setcache
        self.setCache(forKey: festivalData.festival_id, value: festivalData)
        // setfile
        self.setFile(forKey: festivalData.festival_id, value: festivalData)
    }
    
    func removeFromFile(forKey: String) {
        let cachePath = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let filePath = cachePath.appendingPathComponent(forKey)
        
        do {
            try self.fileManager.removeItem(at: filePath)
        } catch let e {
            print("festival_id: removeFile()", e.localizedDescription)
        }
    }
    
    private func getCache(forKey: String) -> FestivalData! {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    private func setCache(forKey: String, value: FestivalData) {
        cache.setObject(value, forKey: NSString(string: forKey))
    }
    
    private func getFile(forKey: String) -> FestivalData? {
        
        let cachePath = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let filePath = cachePath.appendingPathComponent(forKey)
        
        do {
            let str = try String(contentsOf: filePath, encoding: .utf8)
            let str_data = Data(str.utf8)
            let dict_data = try JSONSerialization.jsonObject(with: str_data, options: []) as! [String:String]
            
            let id = dict_data["festival_id"]!
            let name = dict_data["name"]!
            let img_url = dict_data["img_url"]!
            let start_time = dict_data["start_time"]!
            let end_time = dict_data["end_time"]!
            let latitude = dict_data["latitude"]!
            let longitude = dict_data["longitude"]!
            let desc = dict_data["desc"]!
            let etag = dict_data["etag"]!
            
            let data = FestivalData(festival_id: id, name: name, img_url: img_url, start_date: start_time, end_date: end_time, latitude: latitude, longitude: longitude, desc: desc, etag: etag)
            
            return data
        } catch let e {
            print("festival: getFile()", e.localizedDescription)
            
            return nil
        }
    }
    
    private func setFile(forKey: String, value: FestivalData) {
        
        let cachePath = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let filePath = cachePath.appendingPathComponent(forKey)
        
        let dicType: Dictionary<String, String> = [
            "festival_id": value.festival_id,
            "name": value.name,
            "img_url": value.img_url,
            "start_time": value.start_date,
            "end_time": value.end_date,
            "latitude": value.latitude,
            "longitude": value.longitude,
            "desc": value.desc,
            "etag": value.etag
        ]
        
        do {
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: dicType, options: []) {
                let jsonText = String(data: jsonData, encoding: .utf8)
                
                let text = NSString(string: jsonText!)
                
                try text.write(to: filePath, atomically: true, encoding: String.Encoding.utf8.rawValue)
            }
        } catch let e {
            print("festivla: setFile()", e.localizedDescription)
        }
    }
    
    private func fileExist(forKey: String) -> Bool {
        
        let cachePath = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let filePath = cachePath.appendingPathComponent(forKey)
        
        return self.fileManager.fileExists(atPath: filePath.path)
    }
 
    
}

extension FestivalCache {
    private static var festivalCache = FestivalCache()
    static func getFesticalCache() -> FestivalCache {
        return festivalCache
    }
}
