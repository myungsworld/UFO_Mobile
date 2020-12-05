//
//  MenuTask.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/12/01.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation
import Combine
import Alamofire

class MenuTask: ObservableObject {
    
    let festivalIdCache = FestivalIdCache.getFestivalIdCache()
    var menuCache = MenuCache.getMenuCache()
    var storeCache = StoreCache.getStoreCache()
    
    var menuList: [MenuData] = [] {
        didSet {
            objectWillChange.send()
        }
    }
    
    func getMenu(store_id: String) {
        
//        let festival_id = self.festivalIdCache.getFestivalId()
//        let store = self.storeCache.getCache(forKey: String(festival_id))
//        self.getMenuFromURL(store_id: store_id, etag: store![0].etag)
    }
    
    private func getMenuFromURL(store_id: String, etag: String) {
        do {
            let baseURL = Bundle.main.infoDictionary!["BaseURL"] as! String
            guard let url = URL(string: baseURL + "/stores/\(store_id)/menu") else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
            request.setValue("private, max-age=30", forHTTPHeaderField: "Cache-Control")
            request.setValue(etag, forHTTPHeaderField: "If-None-Match")
            
            AF.request(request).responseJSON { response in
                let res = response.response
                let etag = res!.headers["Etag"]! as String
                
                switch response.result {
                case .success(let value):
                    if let menus = value as? [Dictionary<String, String>] {
                        
                        var newData: [MenuData] = []
                        
                        for menu in menus {
                            let menu_id = menu["id"]!
                            let name = menu["name"]!
                            let price = menu["price"]!
                            let img_url = menu["img_url"]!
                            let store_id = menu["store_id"]!
                            
                            let data = MenuData(menu_id: menu_id, name: name, price: price, img_url: img_url, store_id: store_id, etag: etag)
                            
                            newData.append(data)
                        }
                        
                        self.menuList = newData
                        self.menuCache.setCache(forKey: "m_\(store_id)", value: self.menuList)

                    }
                case .failure(let e):
                    
                    switch res?.statusCode {
                    case 304:
                        let data = self.menuCache.getCache(forKey: String(store_id))
                        self.menuList = data!
                        
                        print("menuNotmodified")
                    default:
                        print("error: \(String(describing: e.errorDescription))")
                    }
                    
                }
            }
        }
    }
}
