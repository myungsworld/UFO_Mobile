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
    
    func getStores() {
        let festival_id = self.festivalIdCache.getFestivalId()
        let stores = self.storeCache.getStores(forKey: String(festival_id))
        
        self.getStoresWithURL(festival_id: festival_id, etag: stores?[0].etag ?? "")
    }
    
    private func getStoresWithURL(festival_id: Int, etag: String) {
        
        do {
            let baseURL = Bundle.main.infoDictionary!["BaseURL"] as! String
            guard let url = URL(string: baseURL + "/festival/\(festival_id)/stores") else { return }
            
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
                    if let stores = value as? [Dictionary<String, String>] {
                        
                        var newData: [StoreData] = []
                        
                        for store in stores {
                            let id = store["id"]!
                            let name = store["name"]!
                            let img_url = store["img_url"]!
                            let start_time = store["start_time"]!
                            let end_time = store["end_time"]!
                            let latitude = store["latitude"]!
                            let longitude = store["longitude"]!
                            let desc = store["desc"]!
                            let festival_id = store["festival_id"]!

                            let data = StoreData(id: id, name: name, img_url: img_url, start_time: start_time, end_time: end_time, latitude: latitude, longitude: longitude, desc: desc, festival_id: festival_id, etag: etag)
                            
                            newData.append(data)
                        }
    
                        self.store_data = newData
                        self.storeCache.setStores(storesData: self.store_data)
                        
                        self.grid = []
                        for i in stride(from: 0, to: self.store_data.count, by: 2) {
                            if i != self.store_data.count {
                                self.grid.append(i)
                            }
                        }
                    }
                case .failure(let e):
                    
                    switch res?.statusCode {
                    case 304:
                        let data = self.storeCache.getStores(forKey: String(festival_id))
                        self.store_data = data!
                        
                        self.grid = []
                        for i in stride(from: 0, to: self.store_data.count, by: 2) {
                            if i != self.store_data.count {
                                self.grid.append(i)
                            }
                        }
                        
                        print("NotMOdified")
                    default:
                        print("error: \(String(describing: e.errorDescription))")
                    }
                    
                    
                }
            }
        }
    }
}
