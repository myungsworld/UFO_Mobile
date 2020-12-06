//
//  FestivalTask.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/11/25.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class FestivalTask: ObservableObject {
    
    let festivalIdCache = FestivalIdCache.getFestivalIdCache()
    let festivalCache = FestivalCache.getFesticalCache()
    
    var festivalList: [FestivalListData] = [] {
        didSet {
            objectWillChange.send()
        }
    }
    
    var festivalData: FestivalData? = nil {
        didSet {
            objectWillChange.send()
        }
    }
    
    func getFestivalList() {
        let baseURL = Bundle.main.infoDictionary!["BaseURL"] as! String
        guard let url = URL(string: baseURL + "/festival") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        AF.request(request).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                if let festivals = value as? [Dictionary<String, String>] {
                    
                    var tmpArr: [FestivalListData] = []
                    
                    for festival in festivals {
                        
                        let id = festival["id"]!
                        let name = festival["name"]!
                        
                        tmpArr.append(FestivalListData(festival_id: id, name: name))
                    }
                    
                    self.festivalList = tmpArr
                }
                
            case .failure(let error):
                print("error: \(String(describing: error.errorDescription))")
            }
        }
        
    }
    
    func getFestival() {
        
        print("A")
        
        let festival_id = self.festivalIdCache.getFestivalId()
        let data = self.festivalCache.getCache(forKey: String(festival_id))
        
        self.getFestivalFromURL(festival_id: festival_id, etag: data?.etag ?? "")
    }
    
    private func getFestivalFromURL(festival_id: Int, etag: String) {
        
        let baseURL = Bundle.main.infoDictionary!["BaseURL"] as! String
        guard let url = URL(string: baseURL + "/festival/\(festival_id)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.setValue("private, max-age=900", forHTTPHeaderField: "Cache-Control")
        request.setValue(etag, forHTTPHeaderField: "If-None-Match")
        
        AF.request(request).responseJSON { response in
            
            let res = response.response
            let etag = res!.headers["Etag"]! as String
        
            switch response.result {
            case .success(let value):
                
                if let festival = value as? Dictionary<String, String> {
                    
                    let id = festival["id"]!
                    let name = festival["name"]!
                    let img_url = festival["img_url"]!
                    let start_time = festival["start_time"]!
                    let end_time = festival["end_time"]!
                    let latitude = festival["latitude"]!
                    let longitude = festival["longitude"]!
                    let desc = festival["desc"]!
                    
                    let data = FestivalData(festival_id: id, name: name, img_url: img_url, start_date: start_time, end_date: end_time, latitude: latitude, longitude: longitude, desc: desc, etag: etag)
                    
                    self.festivalCache.setCache(forKey: String(festival_id), value: data)
                    self.festivalData = data
                }
                
            case .failure(let error):
                
                switch res!.statusCode {
                case 304:
                    
                    let data = self.festivalCache.getCache(forKey: String(festival_id))
                    self.festivalData = data
                    
                    print("Not Modified")
                default:
                    print("error: \(String(describing: error.errorDescription))")
                }
            }
        }
    }
}
