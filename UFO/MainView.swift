//
//  MainView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI
import Combine


struct MainView: View {
    
    @State var selected = 0
    @State var isPresented = false
    @State var isPresented2 = false
    @State private var chargeMoney = ""
    @State private var sendMoney = ""
    @State private var password = ""
    
    @EnvironmentObject var hometask : HomeTask
    
    var body: some View {
        
        TabView(selection: $selected) {
            
            // Home
            ZStack  {
                NavigationView {
                    HomeView()
                        .navigationBarTitle("Home", displayMode: .inline)
                    
                }
            }
            .tabItem({
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
