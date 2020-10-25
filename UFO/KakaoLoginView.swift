//
//  KakaoLoginView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/24.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI
import KakaoSDKAuth
import KakaoSDKUser

struct KakaoLoginView: View {
    
    var body: some View {
        
        VStack {
            
            Button(action: {
                if (AuthApi.isKakaoTalkLoginAvailable()) {
                    AuthApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                        
                        if let error = error {
                            print(error)
                        } else {
                            print("loginWithKakaoTalk() success.")
                            
                            //do something
                            if let token = oauthToken {
                                print(token.accessToken)
                            }
                        }
                    }
                }
            }) {
                Text("Login")
            }
            
            Button(action: {
                UserApi.shared.accessTokenInfo { (accessTokenInfo, error) in
                    if let error = error {
                        print(error)
                    } else {
                        print("accessTokenInfo() success.")
                        
                        //do something
                        if let token = accessTokenInfo {
                            print(token)
                        }
                    }
                }
            }) {
                Text("AccessTokenInfo")
            }
            
            Button(action: {
                UserApi.shared.logout { (error) in
                    if let error = error {
                        print(error)
                    } else {
                        print("logout() success")
                    }
                }
            }) {
                Text("Logout")
            }
            
            Button(action: {
                UserApi.shared.me() { (user, error) in
                    if let error = error {
                        print(error)
                    } else {
                        print("me() success")
                        
                        //do something
                        print(user)
                    }
                }
            }) {
                Text("me")
            }
        }
        
    }
}

struct KakaoLoginView_Previews: PreviewProvider {
    static var previews: some View {
        KakaoLoginView()
    }
}
