
import SwiftUI
import UIKit
import AVFoundation

import Combine
import CoreImage.CIFilterBuiltins

struct ChargeView: View {
    
    @EnvironmentObject var chargeTask: ChargeTask
    @State private var money = ""
    
    var body: some View {
        
        NavigationView{
            VStack {
                
                TextField("충전 금액", text : $money)
                Button("충전하기") {
                    
                    self.chargeTask.amount = self.money
                    self.chargeTask.chargeMoney()
                }
            }
        }
    }
}

struct ChargeView_Previews: PreviewProvider {
    static var previews: some View {
        ChargeView()
    }
}
