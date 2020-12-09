
import SwiftUI
import UIKit
import AVFoundation
import CodeScanner
import Combine
import CoreImage.CIFilterBuiltins


struct HomeView: View {
    
    @EnvironmentObject var hometask: HomeTask
    @EnvironmentObject var sendMoneyTask: SendMoneyTask
    @EnvironmentObject var chargeTask: ChargeTask
    @EnvironmentObject var userTask: UserTask
    
    @State private var name  = "송동명"
    @State private var money = ""
    
    @Binding var selected : Int
    var body: some View {
        
        // Login 상태일때,
        if self.userTask.isLogin {
            ZStack(alignment: .top) {
                
                CodeScannerView(codeTypes: [.qr], completion: self.handleScan)
                
                NavigationLink(destination: SendMoneyView(), isActive: self.$hometask.showTransferModal) {
                    Spacer().fixedSize()
                }
                
                SlideOverView {
                    VStack {
                        
                        Image(uiImage: generateQRcode(from: "\(name)\n\(money)"))
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                        
                        Spacer()
                    }
                }
                
                .sheet(isPresented: self.$chargeTask.showChargeModal) {
                    ChargeView()
                        .environmentObject(self.chargeTask)
                }
            }
            .navigationBarItems(trailing: Button(action : {
                self.chargeTask.showChargeModal.toggle()
            }, label: {
                Text("충전")
            }))
        } else {
            // Logout일 때,
            HomeViewBeforeLogin(selected : $selected)
        }
    }
    
    func generateQRcode(from string: String) ->UIImage {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        let data = Data(string.utf8)
        
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        
        switch result {
        case .success(let code):
            
            self.sendMoneyTask.receiver = code
            self.hometask.showTransferModal.toggle()
            
        case .failure(let error):
            print("Scanning failed", error)
        }
    }
}


