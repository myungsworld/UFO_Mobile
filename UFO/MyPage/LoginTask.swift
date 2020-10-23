//
//  LoginTask.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class LoginTask: ObservableObject {

    var useremail: String = "" {
        didSet {
            objectWillChange.send()
        }
    }
    
    var userpassword: String = "" {
        didSet {
            objectWillChange.send()
        }
    }
    
    var isLogin: Bool = false {
        didSet { // what's different with willSet
            objectWillChange.send()
            
        }
    }
    
    var result: Bool = false {
        didSet {
            withAnimation() {
                objectWillChange.send()
            }
        }
    }
    
    func httpLogin(loginData: LoginData) {
        
        do {
                
            guard let url = URL(string: "http://172.30.1.27:5000/user/login") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            print(loginData)
            request.httpBody = try JSONEncoder().encode(loginData)
                
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                guard let res = response as? HTTPURLResponse, let jsonData = data else {
                    return
                }
                
                DispatchQueue.main.async {
                    print(res.statusCode)
                    print(jsonData)

//                    self.result = true
                }
            }
                
            task.resume()
            
        } catch {
            return
        }

    }
    
    
}
