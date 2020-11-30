
//  HttpAuthTask.swift
//  UFO
//
//  Created by myungsworld on 2020/11/30.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.


import Foundation
import Combine

class HttpAuth: ObservableObject {
    var didChange = PassthroughSubject<HttpAuth, Never>()
    
    var authenticated = false {
        didSet {
            didChange.send(self)
        }
    }
    
    func transferMoney(sender: String, receiver: String, amount : String , org: String) {
        guard let url = URL(string: "https://68fe4bbcfc5c.ngrok.io/api/transferMoney") else { return }
        
        let body : [String: String] = [sender: "myung", receiver : "min", amount : "100", org : "SalesOrg"]
        
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("text/html", forHTTPHeaderField: "Contect-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error{
                print(error);
                return;
            }
    
            if let response = response {
                print(response)
            }
            
            if let data = data {
                print(data)
            }
            
        }.resume()
    }
}
