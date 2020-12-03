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
    var fileManager: FileManager
    
    init() {
        self.fileManager = FileManager.default
    }
    
    func getMenu(forKey: String) -> [MenuData]? {
        let key = "m_\(forKey)"
        
        guard let menuData = self.getCache(forKey: key) else {
            
            if !self.fileExist(forKey: key) {
                return nil
            } else {
                let menuData = self.getFile(forKey: key)
                
                self.setCache(forKey: key, value: menuData!)
                
                return menuData
            }
        }
        
        return menuData
    }
    
    func setMenu(menuData: [MenuData]) {
        let key = "m_\(menuData[0].store_id)"
        
        self.setCache(forKey: key, value: menuData)
        self.setFile(forKey: key, value: menuData)
    }
    
    func removeFromFile() {
        
    }
    
    private func getCache(forKey: String) -> [MenuData]! {
        let value = cache.object(forKey: NSString(string: forKey)) as? [MenuData]
        
        if value == nil {
            let log = String(describing: self) + "." + #function + " : Cache Miss"
            NSLog(log)
        } else {
            let log = String(describing: self) + "." + #function + " : Cache Hit"
            NSLog(log)
        }
        
        return value

    }
    
    private func setCache(forKey: String, value: [MenuData]) {
        let newVal = value as NSArray
        cache.setObject(newVal, forKey: NSString(string: forKey))
    }
    
    private func getFile(forKey: String) -> [MenuData]? {
        
        let cachePath = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let filePath = cachePath.appendingPathComponent(forKey)
        
        do {
            let str = try String(contentsOf: filePath, encoding: .utf8)
            let str_data = Data(str.utf8)
            let jsonArr = try JSONSerialization.jsonObject(with: str_data, options: []) as! [Dictionary<String, String>]
            
            var newVal: [MenuData] = []
            
            for json in jsonArr {
                
                let menu_id = json["menu_id"]!
                let name = json["name"]!
                let img_url = json["img_url"]!
                let store_id = json["store_id"]!
                let price = json["price"]!
                let etag = json["etag"]!
                
                let data = MenuData(menu_id: menu_id, name: name, price: price, img_url: img_url, store_id: store_id, etag: etag)
                
                newVal.append(data)
            }
            
            return newVal
            
        } catch let e {
            print(e.localizedDescription)
            return nil
        }
    }
    
    private func setFile(forKey: String, value: [MenuData]) {
        
        let cachePath = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let filePath = cachePath.appendingPathComponent(forKey)
        
        var newVal: [Dictionary<String, String>] = []
        for menu in value {
            let dicType: Dictionary<String, String> = [
                "id": menu.menu_id,
                "name": menu.name,
                "img_url": menu.img_url,
                "price": menu.price,
                "store_id": menu.store_id,
                "etag": menu.etag,
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

extension MenuCache {
    private static var menuCache = MenuCache()
    static func getMenuCache() -> MenuCache {
        return menuCache
    }
}
