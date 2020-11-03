//
//  HomeView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI
//import CodeScanner

struct HomeView: View {

    var body: some View {
        ZStack(alignment: .top) {
            
            CodeScannerView(codeTypes: [.qr], completion: self.handleScan)
            SlideOverView {
                VStack {
                    Text("Slid Over View")
                    Spacer()
                }
            }
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {

        switch result {
        case .success(let code):
            print(code)
//            Alert(title: Text("important message"), message: Text("Wear sun"), dismissButton: .default(Text("asd")))
                    
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
