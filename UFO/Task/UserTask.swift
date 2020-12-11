//
//  UserTask.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/12/06.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser
import Alamofire

class UserTask: ObservableObject {
    
    var isLogin: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
    
    var user: User? = nil {
        didSet {
            objectWillChange.send()
        }
    }
    
    func login() {
        if (AuthApi.isKakaoTalkLoginAvailable()) {

            AuthApi.shared.loginWithKakaoTalk { (oauthToken, error) in

                if let error = error {
                    print(error)
                    self.isLogin = false
                    
                    return
                    
                } else {
                    self.me()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        
                        let fabricURL = Bundle.main.infoDictionary!["FabricURL"] as! String
                        guard let url = URL(string: fabricURL + "/user/login") else { return }
                    
                        let kakao_id = String(self.user?.id ?? -1)
                        
                        if kakao_id == "-1" {
                            print("kakao login failed")
                            return
                        }
                        
                        let body = ["kakao_id" : kakao_id]
                        let finalBody = try! JSONSerialization.data(withJSONObject: body, options: [])

                        var request = URLRequest(url:url)
                        request.httpMethod = "POST"
                        request.httpBody = finalBody
                        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                        
                        AF.request(request).responseJSON { response in

                            switch response.result {
                            case .success(_):
                                
                                self.isLogin = true
                            case .failure(let error):
                                
                                print("error: \(String(describing: error.errorDescription))")
                            }
                        }
                    }
                }
            }
        }
    }
    
    func signup() {
        if (AuthApi.isKakaoTalkLoginAvailable()) {

            AuthApi.shared.loginWithKakaoTalk { (oauthToken, error) in

                if let error = error {
                    print(error)
                    self.isLogin = false
                    
                    return
                    
                } else {
                    self.me()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        
                        let fabricURL = Bundle.main.infoDictionary!["FabricURL"] as! String
                        guard let url = URL(string: fabricURL + "/user/signup") else { return }
                    
                        let kakao_id = String(self.user?.id ?? -1)
                        
                        if kakao_id == "-1" {
                            print("kakao login failed")
                            return
                        }
                        
                        let body = ["kakao_id" : kakao_id]
                        let finalBody = try! JSONSerialization.data(withJSONObject: body, options: [])

                        var request = URLRequest(url:url)
                        request.httpMethod = "POST"
                        request.httpBody = finalBody
                        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                        
                        AF.request(request).responseJSON { response in

                            switch response.result {
                            case .success(_):
                                
                                self.isLogin = true
                            case .failure(let error):
                                
                                print("error: \(String(describing: error.errorDescription))")
                            }
                        }
                    }
                }
            }
        }
    }
    
    func me() {
    
        UserApi.shared.me() { (user, error) in
            
            if let error = error {
                self.isLogin = false
                
                return
            }
            
            if let user = user {
                self.isLogin = true
                self.user = user
                return
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
}
