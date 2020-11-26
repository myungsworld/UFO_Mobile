//
//  FestivalTask.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/11/25.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation
import Combine
import Alamofire

class FestivalTask: ObservableObject {
    
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
//            request.setValue("private, max-age=30", forHTTPHeaderField: "Cache-Control")
            
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
}
