//
//  FestivalTask.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/11/25.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation
//import Combine
import Alamofire

class FestivalTask: ObservableObject {
    
    let festivalCache = FestivalCache.getFesticalCache()
    
    var festival_list: [FestivalListData] = [] {
        didSet {
            objectWillChange.send()
        }
    }
    
    var festival_data: [FestivalData] = [] {
        didSet {
            objectWillChange.send()
        }
    }
    
    func getFestivalList() {
        do {
            let baseURL = Bundle.main.infoDictionary!["BaseURL"] as! String
            guard let url = URL(string: baseURL + "/festival") else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.cachePolicy = .useProtocolCachePolicy
            request.setValue("private, max-age=30", forHTTPHeaderField: "Cache-Control")
            
            AF.request(request).responseJSON { response in
                
                switch response.result {
                case .success(let value):
                    if let jsonObj = value as? [Dictionary<String, String>] {
                        
                        for item in jsonObj {
                            
                            let id = item["id"]!
                            let name = item["name"]!
                            
                            self.festival_list.append(FestivalListData(festival_id: id, name: name))
                        }
                        
                    }
                    
                case .failure(let error):
                    print("error: \(String(describing: error.errorDescription))")
                }
            }
        }
    }

    func getFestival(festival_id: Int) {
        do {
            let baseURL = Bundle.main.infoDictionary!["BaseURL"] as! String
            guard let url = URL(string: baseURL + "/festival/\(festival_id)") else { return }
            
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.cachePolicy = .useProtocolCachePolicy
            request.setValue("private, max-age=900", forHTTPHeaderField: "Cache-Control")
            
            AF.request(request).responseJSON { response in
                
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
                        
                        let data = FestivalData(festival_id: id, name: name, img_url: img_url, start_date: start_time, end_date: end_time, latitude: latitude, longitude: longitude, desc: desc)
                        
                        self.festivalCache.setFestival(festivalData: data)
                        
                    }
                    
                case .failure(let error):
                    print("error: \(String(describing: error.errorDescription))")
                }
            }
        }
    }
}
