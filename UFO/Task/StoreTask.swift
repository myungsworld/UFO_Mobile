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
    
    let festivalIdCache = FestivalIdCache.getFestivalIdCache()
    let storeCache = StoreCache.getStoreCache()
    let menuCache = MenuCache.getMenuCache()
    
    var storeList: [StoreListData] = [] {
        didSet {
            objectWillChange.send()
        }
    }
    
    var storeData: StoreData? = nil {
        didSet {
            objectWillChange.send()
        }
    }
   
    var menuList: [MenuData] = [] {
        didSet {
            objectWillChange.send()
        }
    }
    
    var showMap: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
    
    func getStoreList() {
        
        let festival_id = self.festivalIdCache.getFestivalId()
        print(festival_id)
        
        let baseURL = Bundle.main.infoDictionary!["BaseURL"] as! String
        guard let url = URL(string: baseURL + "/festival/\(festival_id)/store") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        AF.request(request).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                
                if let stores = value as? [Dictionary<String, Any>] {
                    
                    var tmpArr: [StoreListData] = []
                    
                    for store in stores {
                        
                        let id = store["id"] as? Int
                        let name = store["name"] as? String
                        let img_url = store["img_url"] as? String
                        let desc = store["desc"] as? String
                        
                        tmpArr.append(StoreListData(store_id: String(id!), name: name!, img_url: img_url!, desc: desc!))
                    }
                    
                    self.storeList = tmpArr
                }
                
            case .failure(let error):
                print("error: \(String(describing: error.errorDescription))")
            }
        }
    }
    
    func getStore(store_id: String) {
        
        let store = self.storeCache.getCache(forKey: store_id)
        let menu = self.menuCache.getCache(forKey: store_id)
        
        self.getStoreFromURL(store_id: store_id, etag: store?.etag ?? "")
        self.getStoreMenu(store_id: store_id, etag: menu?[0].etag ?? "")
    }
    
    private func getStoreFromURL(store_id: String, etag: String) {
        
        let festival_id = self.festivalIdCache.getFestivalId()
        
        let baseURL = Bundle.main.infoDictionary!["BaseURL"] as! String
        print(baseURL + "/festival/\(festival_id)/store/\(store_id)")
        guard let url = URL(string: baseURL + "/festival/\(festival_id)/store/\(store_id)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.setValue("private, max-age=900", forHTTPHeaderField: "Cache-Control")
        request.setValue(etag, forHTTPHeaderField: "If-None-Match")
        
        AF.request(request).responseJSON { response in
            
            let res = response.response!
            let etag = res.headers["Etag"]! as String
            
            switch response.result {
            case .success(let value):
                if let store = value as? Dictionary<String, Any> {

                    let store_id = store["id"] as? Int
                    let name = store["name"] as? String
                    let img_url = store["img_url"] as? String
                    let start_time = store["start_time"] as? String
                    let end_time = store["end_time"] as? String
                    let latitude = store["latitude"] as? Double
                    let longitude = store["longitude"] as? Double
                    let desc = store["desc"] as? String
                    let festival_id = store["festival_id"] as? Int
                    
                    let data = StoreData(store_id: String(store_id!), name: name!, img_url: img_url!, start_time: start_time!, end_time: end_time!, latitude: String(latitude!), longitude: String(longitude!), desc: desc!, festival_id: String(festival_id!), etag: etag)

                    self.storeCache.setCache(forKey: String(store_id!), value: data)
                    self.storeData = data
                }

            case .failure(let e):

                switch res.statusCode {
                case 304:
                    let data = self.storeCache.getCache(forKey: store_id)
                    self.storeData = data!

                    print("NotMOdified")
                default:
                    print("error: \(String(describing: e.errorDescription))")
                }
            }
        }
    }
    
    private func getStoreMenu(store_id: String, etag: String) {
        
        let festival_id = self.festivalIdCache.getFestivalId()
        
        let baseURL = Bundle.main.infoDictionary!["BaseURL"] as! String
        print(baseURL + "/festival/\(festival_id)/store/\(store_id)/menu")
        guard let url = URL(string: baseURL + "/festival/\(festival_id)/store/\(store_id)/menu") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.setValue("private, max-age=900", forHTTPHeaderField: "Cache-Control")
        request.setValue(etag, forHTTPHeaderField: "If-None-Match")
        
        AF.request(request).responseJSON { response in
            let res = response.response!
            let etag = res.headers["Etag"]! as String
            
            switch response.result {
            case .success(let value):
                if let menus = value as? [Dictionary<String, Any>] {
                    
                    var newData: [MenuData] = []
                    
                    for menu in menus {
                        let menu_id = menu["id"] as? Int
                        let name = menu["name"] as? String
                        let price = menu["price"] as? Int
                        let img_url = menu["img_url"] as? String
                        let store_id = menu["store_id"] as? Int
                        
                        let data = MenuData(menu_id: String(menu_id!), name: name!, price: String(price!), img_url: img_url!, store_id: String(store_id!), etag: etag)

                        newData.append(data)
                    }
                    
                    self.menuList = newData
                    self.menuCache.setCache(forKey: store_id, value: self.menuList)
                }
                
            case .failure(let e):
                
                switch res.statusCode {
                case 304:
                    let data = self.menuCache.getCache(forKey: store_id)!
                    self.menuList = data
                    
                    print("menuNotmodified")
                default:
                    print("error: \(String(describing: e.errorDescription))")
                }
            }
        }
    }
}
