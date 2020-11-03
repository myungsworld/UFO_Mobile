//
//  BoothTask.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation
import Combine

class StoreTask: ObservableObject {
    
    var data: [StoreData] = [] {
        
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
            
            guard let url = URL(string: "http://172.30.1.48:8080/festival/\(festival_id)") else { return }
            
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
                        
                        let stores = try! JSONSerialization.jsonObject(with: data, options: []) as! [Any]
                        
                        for store in stores {
                        
                            let store = store as! Dictionary<String, Any>
                            let store_menu = store["menu"] as! Array<Any>
                        
                            let store_name = store["name"] as! String
                            let store_url = store["url"] as! String
                            
                            var menuList: [StoreMenuData] = []
                            
                            for menu in store_menu {
                                
                                let menu = menu as! Dictionary<String, Any>
                                
                                let menu_name = menu["name"] as! String
                                let menu_price = menu["price"] as! Int
                                let menu_url = menu["url"] as! String
                                
                                menuList.append(StoreMenuData(name: menu_name, price: menu_price, url: menu_url))
                            }
                            
                            self.data.append(StoreData(name: store_name, url: store_url, menu: menuList))
                            
                        }
                    }
                    
                    for i in stride(from: 0, to: self.data.count, by: 2) {
                        if i != self.data.count {
                            self.grid.append(i)
                        }
                    }
                    
                }
            }
            
            task.resume()
        }
    }
    
    
}
