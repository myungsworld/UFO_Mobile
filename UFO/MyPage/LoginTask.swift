//
//  LoginTask.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/11/07.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation
import Combine
import KakaoSDKAuth
import KakaoSDKUser

class LoginTask: ObservableObject {
    
    var isLogin: Bool = false {
        
        didSet {
            objectWillChange.send()
        }
    }
    
    var id: String = "" {
        
        didSet {
            objectWillChange.send()
        }
    }
    
    func loginWithKakaoTalk() {
        
        if (AuthApi.isKakaoTalkLoginAvailable()) {

            AuthApi.shared.loginWithKakaoTalk { (oauthToken, error) in

                if let error = error {
                    print(error)
                    self.isLogin = false
                    
                    return
                    
                } else {
                    self.me()
                    self.isLogin = true
                }
            }
        }
    }
    
    func me() {
    
        UserApi.shared.me() { (user, error) in
            
            if let error = error {
                print(error)
                self.isLogin = false
                return
            }
            
            if let user = user {
                
                self.id = String(user.id)
                
                do {
                    guard let url = URL(string: "http://172.30.1.31:8080/signup") else { return }
                    
                    let json: [String: String] = ["id": self.id]
                    let jsonData = try? JSONSerialization.data(withJSONObject: json)
                    
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    request.httpBody = jsonData
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    
                    let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
                        
                        guard error == nil else {
                            print("Error: \(error)")
                            return
                        }
                        
                        guard let data = data else {
                            print("No data Found")
                            return
                        }
                        
                        guard let res = response as? HTTPURLResponse else {
                            print("no response")
                            return
                        }
                        DispatchQueue.main.async {
                            print(res.statusCode)
                        }
                    }
                    
                    task.resume()
                }
                
                self.isLogin = true
            }
        }
        
    }
    
    func logout() {
        UserApi.shared.logout { (error) in
            if let error = error {
                print(error)

                return
            } else {
                self.isLogin = false
            }
            
        }
    }
    
    func accessTokenInfo() {
        
        UserApi.shared.accessTokenInfo { (accessTokenInfo, error) in
            if let error = error {
                print(error)
                
                return
            } else {
                print("accessTokenInfo() success.")
                
                //do something
                if let token = accessTokenInfo {
                    print(token)
                }
            }
        }
    }
}
