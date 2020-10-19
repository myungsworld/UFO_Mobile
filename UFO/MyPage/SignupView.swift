//
//  SignupView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct SignupView: View {
    
    @EnvironmentObject var signupTask: SignupTask
    
    var body: some View {
    
        VStack {
            // Show some message when userpassword and confirmpassword don't match
            VStack {
                
                SignupEmailTextField(useremail: self.$signupTask.useremail)
                
                Divider()
                SignupPasswordTextField(userpassword: self.$signupTask.userpassword)
                
                Divider()
                SignupConfirmTextField(confirmpassword: self.$signupTask.confirmpassword)
                
                if !self.signupTask.isMatchedPassword {
                    Text("Password isn't matched. Please Check")
                        .foregroundColor(Color.red)
                        .font(.system(size: 12))
                        .padding(.leading, -50)
                        .offset(y: -20)
                }
                
                Divider()
                SignupUserNameTextField(username: self.$signupTask.username)
                
                Divider()
                SignupUserPhoneTextField(userphone: self.$signupTask.userphone)
                
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 15)
            .padding(.top, 25)
            
            SignupButton()

        }
        
        .alert(isPresented: self.$signupTask.result) {
            Alert(title: Text("Completed Sign Up"), message: Text("Welcome to KNUCoin"))
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}

struct SignupEmailTextField: View {
    
    @Binding var useremail: String
    
    var body: some View {
        HStack(spacing: 15) {
            
            Image(systemName: "envelope")
                .foregroundColor(.black)
            
            TextField("Enter your Email", text: self.$useremail)
            
        }.padding(.vertical, 20)
    }
}

struct SignupPasswordTextField: View {
    
    @Binding var userpassword: String
    
    var body: some View {
        HStack(spacing: 15) {
            
            Image(systemName: "lock")
                .resizable()
                .frame(width: 15, height:18)
                .foregroundColor(.black)
            
            SecureField("Password", text: self.$userpassword)
            
            Button(action: {
                
            }) {
                
                Image(systemName: "eye")
                    .foregroundColor(.black)
            }
        }.padding(.vertical, 20)
    }
}

struct SignupConfirmTextField: View {
    
    @Binding var confirmpassword: String
    
    var body: some View {
        HStack(spacing: 15) {
            
            Image(systemName: "lock")
                .resizable()
                .frame(width: 15, height:18)
                .foregroundColor(.black)
            
            SecureField("Confirm Password", text: self.$confirmpassword)
            
            Button(action: {
                
            }) {
                
                Image(systemName: "eye")
                    .foregroundColor(.black)
            }
        }.padding(.vertical, 20)
    }
}

struct SignupUserNameTextField: View {
    
    @Binding var username: String
    
    var body: some View {
        
        HStack(spacing: 15) {
            
            Image(systemName: "person")
                .foregroundColor(.black)
            
            TextField("Enter your Name", text: self.$username)
            
        }.padding(.vertical, 20)
    }
}

struct SignupUserPhoneTextField: View {
    
    @Binding var userphone: String
    
    var body: some View {
        
        HStack(spacing: 15) {
            
            Image(systemName: "phone")
                .foregroundColor(.black)
            
            TextField("Enter your Phone Number", text: self.$userphone)
            
        }.padding(.vertical, 20)
    }
}

struct SignupButton: View {
 
    @EnvironmentObject var signupTask: SignupTask
    
    var body: some View {
        Button(action: {
            
            let signupData = SignupData(email: self.signupTask.useremail, pw: self.signupTask.userpassword, name: self.signupTask.username, userphone: self.signupTask.userphone)
            self.signupTask.signupHttp(signupData: signupData)

        }) {
            
            Text("SignUp")
                .foregroundColor(.black)
                .fontWeight(.bold)
                .padding(.vertical)
                .frame(width: UIScreen.main.bounds.width - 100)
            
        }.background(Color.white)
        .cornerRadius(8)
        .offset(y: -50)
        .padding(.bottom, -40)
        .shadow(radius: 15)

    }
}
