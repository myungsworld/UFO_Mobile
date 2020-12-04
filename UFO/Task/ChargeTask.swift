//
//  ChargeTask.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/12/04.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation
import Combine
import Alamofire

class ChargeTask: ObservableObject {
    
    var amount: String = "" {
        didSet {
            objectWillChange.send()
        }
    }
    
    var showChargeModal: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
    
    func chargeMoney() {
        
        let id = "asd"
        let baseURL = Bundle.main.infoDictionary!["BaseURL"] as! String
        guard let url = URL(string: baseURL + "/chargeMoney") else { return }
        
        let body = ["id" : id, "amount" : self.amount]
        let finalBody = try! JSONSerialization.data(withJSONObject: body, options: [])
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        AF.request(request).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                
                if let jsonObj = value as? Dictionary<String, String> {
                    print(jsonObj)
                }
                
            case .failure(let error):
                print("error: \(String(describing: error.errorDescription))")
            }
            
            self.showChargeModal = false
        }
    }
}
