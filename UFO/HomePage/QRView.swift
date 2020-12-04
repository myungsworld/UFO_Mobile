
import SwiftUI
import UIKit
import AVFoundation
import CodeScanner
import Combine
import CoreImage.CIFilterBuiltins


struct QRView: View {
    
    @EnvironmentObject var http : HttpAuth
    @EnvironmentObject var task : HomeTask
    @State private var money = ""
    
    @State private var showGreeting = true
    
    var body: some View {
       
        TextField("충전할 금액", text: $money)
            .keyboardType(.numberPad)
            .font(.title)
            .padding([.horizontal, .bottom])
        Button(action: {
            self.task.showTransferModal.toggle()
            //self.http.transferMoney(sender: "myung", receiver: "min", amount: money, org: "SalesOrg")
            
        }){
            Text("충전")
        }
        
        Toggle(isOn: $showGreeting) {
            Text("Show welcome message")
        }.padding()
        
        if showGreeting {
            Text("Hello World!")
        }
    }
}

struct QRView_Previews: PreviewProvider {
    static var previews: some View {
        QRView()
    }
}
