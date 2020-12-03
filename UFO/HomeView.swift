
import SwiftUI
import UIKit
import AVFoundation
import CodeScanner
import Combine
import CoreImage.CIFilterBuiltins


struct HomeView: View {
    
    @EnvironmentObject var hometask : HomeTask
    @State private var sender : String = "myung"
    @State private var receiver : String = "min"
    @State private var amount : String = "100"
    @State private var org : String = "CustomerOrg"
    
    @EnvironmentObject var http : HttpAuth
    @State private var name  = "송동명"
    @State private var email = "myungsworld@gmail.com"
    @State private var money = ""
    @State private var password = ""
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    func generateQRcode(from string: String) ->UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    @State private var isPresentingScanner = false
    @State private var scannedCode: String?
    var body: some View {
        
            ZStack(alignment: .top) {
                CodeScannerView(codeTypes: [.qr], completion: self.handleScan)
                    .sheet(isPresented: self.$hometask.click) {
                        TextField("보낼 금액", text: $hometask.sendMoney)
                            .keyboardType(.numberPad)
                            .font(.title)
                            .padding([.horizontal, .bottom])
                        Button(action: {
                            
//                            self.http.transferMoney(sender: "myung", receiver: "min", amount: money, org: "SalesOrg")
                            self.hometask.click.toggle()
                            self.hometask.isPresented3.toggle()
                            
                            //print(hometask.click)
                            
                        }){
                                Text("송금")
                        }
                            
                        
                    }
                
                SlideOverView {
                    VStack {
//                        TextField("보낼 금액", text: $money)
//
//                            .font(.title)
//                            .padding([.horizontal, .bottom])
                        Image(uiImage: generateQRcode(from: "\(name)\n\(money)"))
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                        Spacer()
                    }
                }
                
            }//Zstack
        

    }
    

    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {

        switch result {
        case .success(let code):
            
            withAnimation {
                self.hometask.click.toggle()
            }
            print(code)
            
        case .failure(let error):
            print("Scanning failed", error)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
