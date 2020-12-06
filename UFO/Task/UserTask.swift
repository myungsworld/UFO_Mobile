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
