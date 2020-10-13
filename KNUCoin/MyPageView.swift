//
//  UserInfoView.swift
//  KNUCoin
//
//  Created by Sanghyun Byun on 2020/09/28.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct MyPageView: View {
    
    @State var index = 0
    @EnvironmentObject var loginTask: LoginTask
    
    var body: some View {
        
        VStack {
            
            if self.loginTask.isLogin {
                Text("This is UserInfo View")
            } else {
                LoginSignup(index: self.$index)
            }
            
        }
    .padding()
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}

struct LoginSignup: View {
    
    @Binding var index: Int
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)) {
                        
                        self.index = 0
                    }
                    
                }) {
                    
                    Text("Login")
                        .foregroundColor(self.index == 0 ? .black : .white)
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                        .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                    
                }.background(self.index == 0 ? Color.white : Color.clear)
                    .clipShape(Capsule())
                
                Button(action: {
                    
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)) {
                        
                        self.index = 1
                    }
                    
                }) {
                    
                    Text("Signup")
                        .foregroundColor(self.index == 1 ? .black : .white)
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                        .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                    
                }.background(self.index == 1 ? Color.white : Color.clear)
                    .clipShape(Capsule())
                
                
                
                
            }.background(Color.black.opacity(0.1))
                .clipShape(Capsule())
                .padding(.top, 25)
                .shadow(radius: 15)
            
            if self.index == 0 {
                LoginView()
            } else {
                SignupView()
            }
            
            if self.index == 0 {
                
                Button(action: {
                    
                }) {
                    Text("Forgot Password?")
                        .foregroundColor(.white)
                }
                .padding(.top, 20)
            }
        }
    }
}
