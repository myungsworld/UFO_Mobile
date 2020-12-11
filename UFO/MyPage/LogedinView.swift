//
//  LogedinView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/12/10.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct LogedinView: View {
    
    @EnvironmentObject var userTask: UserTask
    
    var body: some View {
        
        VStack(alignment: .center , spacing: 20) {
            Form {
                Section {
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
                Section {
                    NavigationLink(destination: ChargeRecordView()){
                        Text("충전 내역")
                    }
                }
                Section {
                    NavigationLink(destination: PayRecordView()){
                        Text("결제 내역")
                    }
                }
                Section {
                    NavigationLink(destination: PasswordChangeView()){
                        Text("비밀 번호 변경")
                    }
                }
                
            }//Form
        }
    }
}

struct LogedinView_Previews: PreviewProvider {
    static var previews: some View {
        LogedinView()
    }
}
