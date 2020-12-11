//
//  PasswordView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/12/04.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct PasswordView: View {
    
    @EnvironmentObject var sendMoneyTask: SendMoneyTask
    @State var password: String = ""
    
    var body: some View {
        HStack{
            Spacer()
            VStack {
                
                Spacer()
                
                TextField("비밀 번호 ", text : self.$password)
                    .keyboardType(.numberPad)
                    .font(.title)
                    .padding([.horizontal, .bottom])
                
                Button(action: {
                    self.hideKeyboard()
                    self.sendMoneyTask.sendMoney()
                }, label : {
                    Text("입력")
                })
                
                Button(action: {
                    withAnimation{
                        self.sendMoneyTask.showPasswordModal = false
                    }
                }, label: {
                    Text("취소")
                })
                .offset(x: 150 ,y : -100)
                Spacer()
            }
            Spacer()
        }
    }
}

//struct PasswordView_Previews: PreviewProvider {
//    static var previews: some View {
//        PasswordView()
//    }
//}
