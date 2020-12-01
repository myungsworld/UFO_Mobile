//
//  MainView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @State var selected = 0
    @State private var sender : String = "song"
    @State private var receiver : String = "min"
    @State private var amount : String = "100"
    @State private var org : String = "CustomerOrg"

    var body: some View {
        
        TabView(selection: $selected) {
            
            // Home
            NavigationView {
                HomeView()
                    .navigationBarTitle("Home", displayMode: .inline)
                    .navigationBarItems(trailing:
                                            NavigationLink(destination : ChargeView()){
                                                Text("충전")
                                            })
                    
                    .navigationBarBackButtonHidden(true)
            }.tabItem({
                Text("Home")
            }).tag(0)
            
            // Festival
            NavigationView {
                
                ZStack{
                    FestivalView()
                        .navigationBarTitle("Fetival", displayMode: .inline)
                }
                
            }.tabItem({
                Text("Festival")
            }).tag(1)
            
            // MyPage
            NavigationView {
        
                MyPageView()
                .navigationBarTitle("MyPage", displayMode: .inline)
        
                
            }.tabItem({
                Text("MyPage")
            }).tag(2)
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
