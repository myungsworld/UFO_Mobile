//
//  HomeView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI
//import CodeScanner
import Combine
import CoreImage.CIFilterBuiltins

class HttpAuth: ObservableObject {
    var didChange = PassthroughSubject<HttpAuth, Never>()
    
    var authenticated = false {
        didSet {
            didChange.send(self)
        }
    }
    
    func transferMoney(sender: String, receiver: String, amount : String , org: String) {
        guard let url = URL(string: "http://localhost:8080/api/transferMoney") else { return }
        
        let body : [String: String] = [sender: "myung", receiver : "min", amount : "100", org : "SalesOrg"]
        
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("text/html", forHTTPHeaderField: "Contect-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error{
                print(error);
                return;
            }
    
            if let response = response {
                print(response)
            }
            
            if let data = data {
                print(data)
            }
            
        }.resume()
    }
}

struct HomeView: View {
    
    @State private var sender : String = "myung"
    @State private var receiver : String = "min"
    @State private var amount : String = "100"
    @State private var org : String = "CustomerOrg"
    
    @State private var name  = "송동명"
    @State private var email = "myungsworld@gmail.com"
    
    var http = HttpAuth()
    
    var body: some View {
        ZStack(alignment: .top) {
            
            CodeScannerView(codeTypes: [.qr], completion: self.handleScan)
            SlideOverView {
                VStack {
                    TextField("Name", text: $name)
                        .textContentType(.name)
                        .font(.title)
                        .padding(.horizontal)
                    TextField("Email address", text: $email)
                        .textContentType(.emailAddress)
                        .font(.title)
                        .padding([.horizontal, .bottom])
                    Spacer()
                }
            }
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {

        switch result {
        case .success(let code):
            print(code)
            self.http.transferMoney(sender: "myung", receiver: "min", amount: "100", org: "SalesOrg")
                    
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
