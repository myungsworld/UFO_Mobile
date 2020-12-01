
import SwiftUI
import UIKit
import AVFoundation
import CodeScanner
import Combine
import CoreImage.CIFilterBuiltins

//class HttpAuth: ObservableObject {
//    var didChange = PassthroughSubject<HttpAuth, Never>()
//    
//    var authenticated = false {
//        didSet {
//            didChange.send(self)
//        }
//    }
//    
//    func transferMoney(sender: String, receiver: String, amount : String , org: String) {
//        guard let url = URL(string: "https://68fe4bbcfc5c.ngrok.io/api/transferMoney") else { return }
//        
//        let body : [String: String] = [sender: "myung", receiver : "min", amount : "100", org : "SalesOrg"]
//        
//        let finalBody = try! JSONSerialization.data(withJSONObject: body)
//        
//        var request = URLRequest(url:url)
//        request.httpMethod = "POST"
//        request.httpBody = finalBody
//        request.setValue("text/html", forHTTPHeaderField: "Contect-Type")
//        
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            
//            if let error = error{
//                print(error);
//                return;
//            }
//    
//            if let response = response {
//                print(response)
//            }
//            
//            if let data = data {
//                print(data)
//            }
//            
//        }.resume()
//    }
//}

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
                .sheet(isPresented: self.$hometask.pay) {
                    TextField("보낼 금액", text: $money)
                        .keyboardType(.numberPad)
                        .font(.title)
                        .padding([.horizontal, .bottom])
                    Button(action: {
                        
                        self.http.transferMoney(sender: "myung", receiver: "min", amount: money, org: "SalesOrg")
                        self.hometask.click.toggle()
                        //print(hometask.click)
                        
                    }){
                        NavigationLink(destination:HomeView()){
                            Text("송금")
                        }
                    }
                        
                    
                }
            }//Zstack
    }
    

    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {

        switch result {
        case .success(let code):
            
            withAnimation {
                self.hometask.pay.toggle()
            }
            print(code)
            
            //self.http.transferMoney(sender: "myung", receiver: "min", amount: "100", org: "SalesOrg")
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
