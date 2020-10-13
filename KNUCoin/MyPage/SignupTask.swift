//
//  SignupTask.swift
//  KNUCoin
//
//  Created by Sanghyun Byun on 2020/10/02.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class SignupTask: ObservableObject {
    
    var useremail: String = "" {
        didSet {
            objectWillChange.send()
        }
    }
    
    var userpassword: String = "" {
        didSet {
            self.checkMatchPassword()
            objectWillChange.send()
        }
    }
    
    var confirmpassword: String = "" {
        didSet {
            self.checkMatchPassword()
            objectWillChange.send()
        }
    }
    
    var username: String = "" {
        didSet {
            objectWillChange.send()
        }
    }
    
    var userphone: String = "" {
        didSet {
            objectWillChange.send()
        }
    }
    
    var isMatchedPassword: Bool = true {
        didSet {
            objectWillChange.send()
        }
    }
    var result: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
    
    func checkMatchPassword() {
        if self.userpassword == self.confirmpassword {
            self.isMatchedPassword = true
        } else {
            self.isMatchedPassword = false
        }
    }
    
    func signupHttp(signupData: SignupData) {
            
        do {
                
            guard let url = URL(string: "http://172.30.1.27:5000/user/regist") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(signupData)
                
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                guard let res = response as? HTTPURLResponse, let jsonData = data else {
                    return
                }
                
                
                 DispatchQueue.main.async {
                    print(res.statusCode)
                    print(jsonData)
                    
                     self.result = true
                 }
//                do {
//                    let returnVal = try JSONDecoder().decode(SignupData.self, from: jsonData)
//
//                     DispatchQueue.main.async {
//                        print(res.statusCode)
//                        print(jsonData)
//                         self.result = true
//                     }
//
////                    print(returnVal)
//
//                } catch {
//                    return
//                }
                
            }
                
            task.resume()
        
            
        } catch {
            return
        }
    }
    
}
