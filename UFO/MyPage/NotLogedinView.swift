//
//  NotLogedinView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/12/10.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct NotLogedinView: View {
    
    @EnvironmentObject var userTask: UserTask
    
    var body: some View {
        HStack(alignment: .center , spacing: 20) {
            
            Button(action: {
                self.userTask.login()
            }) {
                Text("로그인")
                    .frame(width: 150, height: 50)
                    .background(Color.blue)
                    .foregroundColor(Color.black)
            }
            
            Button(action: {
                self.userTask.signup()
            }) {
                Text("회원가입")
                    .frame(width: 150, height: 50)
                    .background(Color.blue)
                    .foregroundColor(Color.black)
            }
        }
    }
}

struct NotLogedinView_Previews: PreviewProvider {
    static var previews: some View {
        NotLogedinView()
    }
}
