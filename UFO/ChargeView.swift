
import SwiftUI
import UIKit
import AVFoundation

import Combine
import CoreImage.CIFilterBuiltins

struct ChargeView: View {
    
    @State private var money = ""
    @EnvironmentObject var http : HttpAuth
    @State private var isPresented = false
    @State private var isActive : Bool = false
    @State private var selection : Int? = nil
    var body: some View {
        NavigationView{
            VStack {
                NavigationLink(destination: HomeView(), tag: 1, selection: self.$selection){
                    Text("")
                }
                
                TextField("충전 금액", text : $money)
                Button("충전하기") {
                    self.http.chargeMoney(id: "myung", org: "SalesOrg", amount: money)
                    self.selection = 1
                }
                
            }
            .navigationBarTitle("Processing")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ChargeView_Previews: PreviewProvider {
    static var previews: some View {
        ChargeView()
    }
}
