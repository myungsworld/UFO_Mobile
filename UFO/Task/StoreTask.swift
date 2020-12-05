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
    
    func getStoreList() {
        
        let festival_id = self.festivalIdCache.getFestivalId()
        
        let baseURL = Bundle.main.infoDictionary!["BaseURL"] as! String
        guard let url = URL(string: baseURL + "/festival/\(festival_id)/stores") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        AF.request(request).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                if let stores = value as? [Dictionary<String, String>] {
                    
                    var tmpArr: [StoreListData] = []
                    
                    for store in stores {
                        
                        let id = store["id"]!
                        let name = store["name"]!
                        let img_url = store["img_url"]!
                        let desc = store["desc"]!
                        
                        tmpArr.append(StoreListData(store_id: id, name: name, img_url: img_url, desc: desc))
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
        
        let baseURL = Bundle.main.infoDictionary!["BaseURL"] as! String
        guard let url = URL(string: baseURL + "/store/\(store_id)") else { return }
        
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
                if let store = value as? Dictionary<String, String> {
                    
                    let store_id = store["id"]!
                    let name = store["name"]!
                    let img_url = store["img_url"]!
                    let start_time = store["start_time"]!
                    let end_time = store["end_time"]!
                    let latitude = store["latitude"]!
                    let longitude = store["longitude"]!
                    let desc = store["desc"]!
                    let festival_id = store["festival_id"]!
                    
                    let data = StoreData(store_id: store_id, name: name, img_url: img_url, start_time: start_time, end_time: end_time, latitude: latitude, longitude: longitude, desc: desc, festival_id: festival_id, etag: etag)
                    
                    self.storeCache.setCache(forKey: store_id, value: data)
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
        
        let baseURL = Bundle.main.infoDictionary!["BaseURL"] as! String
        guard let url = URL(string: baseURL + "/store/\(store_id)/menu") else { return }
        
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
