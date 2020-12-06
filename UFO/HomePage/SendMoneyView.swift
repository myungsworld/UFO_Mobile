//
//  SendMoneyView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/12/04.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct SendMoneyView: View {
    
    @EnvironmentObject var sendMoneyTask: SendMoneyTask
    @State var amount: String = ""
    
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        
        VStack {
            TextField("보낼 금액", text: self.$amount)
                .keyboardType(.numberPad)
                .font(.title)
                .padding([.horizontal, .bottom])
            
            Button(action: {
                self.hideKeyboard()
                self.sendMoneyTask.amount = self.amount
                self.sendMoneyTask.showPasswordModal.toggle()

            }){
                Text("송금")
            }
            
            .sheet(isPresented: self.$sendMoneyTask.showPasswordModal) {
                PasswordView()
                    .environmentObject(self.sendMoneyTask)
            }
        }.onReceive(self.sendMoneyTask.publisher) { tmp in
            self.mode.wrappedValue.dismiss()
        }
    }
}

struct SendMoneyView_Previews: PreviewProvider {
    static var previews: some View {
        SendMoneyView()
    }
}
