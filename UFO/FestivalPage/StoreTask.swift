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
            request.cachePolicy = .useProtocolCachePolicy
            request.setValue("private, max-age=30", forHTTPHeaderField: "Cache-Control")
            

            AF.request(request).responseJSON { response in
                
                print(response.response?.headers)
                print(response.response?.statusCode)

            }
            
            
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
