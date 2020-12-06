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
    
    @EnvironmentObject var userTask: UserTask
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            
            if (!self.userTask.isLogin) {
                VStack(alignment: .center , spacing: 20) {
                    
                    Text("ASD")
                    
                    Button(action: {
                        self.userTask.loginWithKakaoTalk()
                    }) {
                        Text("로그인")
                            .frame(width: 150, height: 50)
                            .background(Color.blue)
                            .foregroundColor(Color.black)
                    }
                }
            } else {
                
                HStack(spacing: 20) {
                    
                    URLImageView(url: self.userTask.user?.properties?["profile_image"] ?? "", width: (UIScreen.main.bounds.width - 200) / 2, height: (UIScreen.main.bounds.height - 500) / 2)            
                    
                    Text(self.userTask.user?.kakaoAccount?.profile?.nickname ?? "loading")
                    
                    Button(action: {
                        self.userTask.logout()
                    }) {
                        Text("로그아웃")
                    }
                }
            }
            
            Divider()
        }
        
    }
}

//struct KakaoLoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        KakaoLoginView()
//    }
//}
