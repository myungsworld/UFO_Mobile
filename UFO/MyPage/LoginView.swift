//
//  LoginView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var loginTask: LoginTask
    
    var body: some View {
            
        VStack {
            VStack {
                // Email Box
                LoginEmailTextField(useremail: self.$loginTask.useremail)
                
                Divider()
                
                // Password Box
                LoginPasswordTextField(userpassword: self.$loginTask.userpassword)
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 15)
            .padding(.top, 25)
            
            // Login Button Box
            LoginButton()
        }
        
        .alert(isPresented: self.$loginTask.result) {
            Alert(title: Text("Loged In"),
                  message: Text("Welcome back"),
                  dismissButton: Alert.Button.default(
                    Text("Ok"), action: { self.loginTask.isLogin = true }
                  ))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct LoginEmailTextField: View {
    
    @Binding var useremail: String
    
    var body: some View {
        HStack(spacing: 15) {
            
            Image(systemName: "envelope")
                .foregroundColor(.black)
            
            TextField("Enter your Email", text: self.$useremail)
            
        }.padding(.vertical, 20)
    }
}

struct LoginPasswordTextField: View {
    
    @Binding var userpassword: String
    
    var body: some View {
        HStack(spacing: 15) {
            
            Image(systemName: "lock")
                .resizable()
                .frame(width: 15, height: 18)
                .foregroundColor(.black)
            
            
            SecureField("Enter your password", text: self.$userpassword)
            
            Button(action: {
                
            }) {
                Image(systemName: "eye")
                    .foregroundColor(.black)
            }
            
        }.padding(.vertical, 20)
    }
}


struct LoginButton: View {
    
    @EnvironmentObject var loginTask: LoginTask
    
    var body: some View {
        Button(action: {
            
            let loginData = LoginData(email: self.loginTask.useremail, pw: self.loginTask.userpassword)
            self.loginTask.httpLogin(loginData: loginData)
            
        }) {
            Text("Login")
                .foregroundColor(.black)
                .fontWeight(.bold)
                .padding(.vertical)
                .frame(width: UIScreen.main.bounds.width - 100)
        }.background(Color.white)
        .cornerRadius(8)
        .offset(y: -40)
        .padding(.bottom, -40)
        .shadow(radius: 15)
    }
}

