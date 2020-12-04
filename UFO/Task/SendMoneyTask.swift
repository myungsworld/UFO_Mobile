//
//  SendMoneyTask.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/12/04.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation
import Combine
import Alamofire
import SwiftUI

class SendMoneyTask: ObservableObject {
    
    let publisher: PassthroughSubject<Int, Never> = PassthroughSubject()
    
    var receiver: String = "" {
        didSet {
            objectWillChange.send()
        }
    }
    
    var amount: String = "" {
        didSet {
            objectWillChange.send()
        }
    }
    
    var showPasswordModal: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
    
    func sendMoney() {
        
        let sender = "asd"
        let baseURL = Bundle.main.infoDictionary!["BaseURL"] as! String
        guard let url = URL(string: baseURL + "/transferMoney") else { return }
        
        let body = ["sender": sender, "receiver" : self.receiver, "amount" : self.amount]
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
            
            self.showPasswordModal = false
            self.publisher.send(Array(1...10).randomElement()!)
        }
        
    }
}
