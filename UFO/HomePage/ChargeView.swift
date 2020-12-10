
import SwiftUI
import UIKit
import AVFoundation

import Combine
import CoreImage.CIFilterBuiltins

struct ChargeView: View {
    
    @EnvironmentObject var chargeTask: ChargeTask
    @EnvironmentObject var userTask: UserTask
    @State private var money = ""
    
    var body: some View {
        
        NavigationView{
            VStack {
                
                TextField("충전 금액", text : $money)
                Button("충전하기") {
                    let user_id = self.userTask.user?.id

                    self.chargeTask.amount = self.money
                    self.chargeTask.chargeMoney(user_id: String(user_id!))
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
