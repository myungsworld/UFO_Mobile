//
//  StoreCache.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/12/01.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation

class StoreCache {
    
    var cache = NSCache<NSString, NSArray>()
    var fileManager: FileManager
    
    init() {
        self.fileManager = FileManager.default
    }
    
    func getStores(forKey: String) -> [StoreData]? {
        
        let key = "s_\(forKey)"
        
        guard let storesData = self.getCache(forKey: key) else {
            
            if !self.fileExist(forKey: key) {
                return nil
            } else {
                let storesData = self.getFile(forKey: key)
                
                self.setCache(forKey: key, value: storesData!)
                
                return storesData
            }
        }
        
        return storesData
    }
    
    func setStores(storesData: [StoreData]) {
        
        let key = "s_\(storesData[0].festival_id)"
        
        self.setCache(forKey: key, value: storesData)
        self.setFile(forKey: key, value: storesData)
    }
    
    func removeFromFile() {
    }
    
    private func getCache(forKey: String) -> [StoreData]! {
        let value =  cache.object(forKey: NSString(string: forKey)) as? [StoreData]
        
        if value == nil {
            let log = String(describing: self) + "." + #function + " : Cache Miss"
            NSLog(log)
        } else {
            let log = String(describing: self) + "." + #function + " : Cache Hit"
            NSLog(log)
        }
        
        return value
    }
    
    private func setCache(forKey: String, value: [StoreData]) {
        let newVal = value as NSArray
        cache.setObject(newVal, forKey: NSString(string: forKey))
    }
    
    private func getFile(forKey: String) -> [StoreData]? {
        
        let cachePath = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let filePath = cachePath.appendingPathComponent(forKey)
        
        do {
            let str = try String(contentsOf: filePath, encoding: .utf8)
            let str_data = Data(str.utf8)
            let jsonArr = try JSONSerialization.jsonObject(with: str_data, options: []) as! [Dictionary<String, String>]
            
            var newVal: [StoreData] = []
            
            for json in jsonArr {
                
                let store_id = json["id"]!
                let name = json["name"]!
                let img_url = json["img_url"]!
                let start_time = json["start_time"]!
                let end_time = json["end_time"]!
                let latitude = json["latitude"]!
                let longitude = json["longitude"]!
                let desc = json["desc"]!
                let festival_id = json["festival_id"]!
                let etag = json["etag"]!
                
                let data = StoreData(store_id: store_id, name: name, img_url: img_url, start_time: start_time, end_time: end_time, latitude: latitude, longitude: longitude, desc: desc, festival_id: festival_id, etag: etag)
                
                newVal.append(data)
            }
            
            return newVal
            
        } catch let e {
            print(e.localizedDescription)
            return nil
        }
    }
    
    private func setFile(forKey: String, value: [StoreData]) {
        
        let cachePath = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let filePath = cachePath.appendingPathComponent(forKey)
        
        var newVal: [Dictionary<String, String>] = []
        for store in value {
            let dicType: Dictionary<String, String> = [
                "id": store.store_id,
                "name": store.name,
                "img_url": store.img_url,
                "start_time": store.start_time,
                "end_time": store.end_time,
                "latitude": store.latitude,
                "longitude": store.longitude,
                "desc": store.desc,
                "festival_id": store.festival_id,
                "etag": store.etag
            ]
            
            newVal.append(dicType)
        }
        
        do {
            if let jsonData = try? JSONSerialization.data(withJSONObject: newVal, options: []) {
                let jsonText = String(data: jsonData, encoding: .utf8)
                let text = NSString(string: jsonText!)
                
                try text.write(to: filePath, atomically: true, encoding: String.Encoding.utf8.rawValue)
            }
        } catch let e {
            print("store: setFile()", e.localizedDescription)
        }
    }
    
    private func fileExist(forKey: String) -> Bool {
        let cachePath = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let filePath = cachePath.appendingPathComponent(forKey)
        
        let isExisted = self.fileManager.fileExists(atPath: filePath.path)
        
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

extension StoreCache {
    private static var storeCache = StoreCache()
    static func getStoreCache() -> StoreCache {
        return storeCache
    }
}
