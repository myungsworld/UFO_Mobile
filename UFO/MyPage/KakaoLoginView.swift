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
    
    @EnvironmentObject var loginTask: LoginTask
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            
            if (!self.loginTask.isLogin) {
                VStack(alignment: .center , spacing: 20) {
                    
                    Text("ASD")
                    
                    Button(action: {
                        self.loginTask.loginWithKakaoTalk()
                    }) {
                        Text("로그인")
                            .frame(width: 150, height: 50)
                            .background(Color.blue)
                            .foregroundColor(Color.black)
                    }
                }
            } else {
                
                let username = self.loginTask.id
                
                ProfileView()
//                HStack(spacing: 20) {
//                    Image("boothic1")
//                        .renderingMode(.original)
//                        .resizable()
//                        .frame(width: (UIScreen.main.bounds.width - 200) / 2, height: (UIScreen.main.bounds.height - 500) / 2)
//                        .padding(.leading, 20)
//
//                    Text(username)
//
//                    Button(action: {
//                        self.loginTask.logout()
//                    }) {
//                        Text("로그아웃")
//                    }
//                }
            }
            
//            Divider()
        }
        
    }
}

//struct KakaoLoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        KakaoLoginView()
//    }
//}
