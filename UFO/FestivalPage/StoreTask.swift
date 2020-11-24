//
//  BoothTask.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation
import Combine
import Alamofire

class StoreTask: ObservableObject {
    
    var store_data: [StoreData] = [] {
        
        didSet {
            objectWillChange.send()
        }
    }
    var menu_data: [StoreMenuData] = [] {
        
        didSet {
            objectWillChange.send()
        }
    }
    
    var grid: [Int] = [] {
        didSet {
            objectWillChange.send()
        }
    }
    
    func getStoreInfo(festival_id: Int) {
        
        do {
            let baseURL = Bundle.main.infoDictionary!["BaseURL"] as! String
            guard let url = URL(string: baseURL + "/store/get/\(festival_id)") else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.cachePolicy = .reloadIgnoringCacheData
            
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                guard error == nil else {
                    print("Error: \(error!)")
                    return
                }
                
                guard let data = data else {
                    print("No data Found")
                    return
                }
                
                guard let res = response as? HTTPURLResponse else {
                    print("No response")
                    return
                }
                
                DispatchQueue.main.async {
                
                    print(res.statusCode)
                    print(res.headers)
//                    do {
//
//                        let stores = try! JSONSerialization.jsonObject(with: data, options: []) as! [Any]
//
//                        for store in stores {
//
//                            let store = store as! Dictionary<String, Any>
//
//                            let store_id = store["id"] as! NSNumber
//                            let store_id_str = store_id.stringValue
//
//                            let store_name = store["name"] as! String
//                            let store_url = store["img_url"] as! String
//                            let store_desc = store["desc"] as! String
//
//                            let store_latitude = store["latitude"] as! NSNumber
//                            let store_longitude = store["longitude"] as! NSNumber
//                            let store_latitude_str = store_longitude.stringValue
//                            let store_longitude_str = store_longitude.stringValue
//
//                            self.store_data.append(StoreData(id: store_id_str, name: store_name, url: store_url, desc: store_desc, latitude: store_latitude_str, longitude: store_longitude_str))
//
//                            self.getMenuInfo(store_id: store_id_str)
//
//                        }
//                    }
//
//                    for i in stride(from: 0, to: self.store_data.count, by: 2) {
//                        if i != self.store_data.count {
//                            self.grid.append(i)
//                        }
//                    }
                    
                }
            }
            
            task.resume()
        }
    }
    
    func getMenuInfo(store_id: String) {
        
        do {
            let baseURL = Bundle.main.infoDictionary!["BaseURL"] as! String
             guard let url = URL(string: "\(baseURL)/menu/get/\(store_id)") else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                guard error == nil else {
                    print("Error: \(error!)")
                    return
                }
                
                guard let data = data else {
                    print("No data Found")
                    return
                }
                
                DispatchQueue.main.async {
                    
                    do {
                        
                        let menus = try! JSONSerialization.jsonObject(with: data, options: []) as! [Any]
                        
                        for menu in menus {
                        
                            let menu = menu as! Dictionary<String, Any>
                            
                            let menu_id = menu["id"] as! NSNumber
                            let menu_id_str = menu_id.stringValue
                            
                            let menu_name = menu["name"] as! String
                            let menu_url = menu["img_url"] as! String
                            let menu_price = menu["price"] as! NSNumber
                            let menu_price_str = menu_price.stringValue
                            
                            self.menu_data.append(StoreMenuData(id: menu_id_str, name: menu_name, price: menu_price_str, url: menu_url))
                            
                        }
                    }
                    
//                    for i in stride(from: 0, to: self.store_data.count, by: 2) {
//                        if i != self.store_data.count {
//                            self.grid.append(i)
//                        }
//                    }
                    
                }
            }
            
            task.resume()
        }
    }
    
    
}
