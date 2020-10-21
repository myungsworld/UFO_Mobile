//
//  MainView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @State var selected = 1
    
    var body: some View {
        
        TabView(selection: $selected) {
            
            // Home
            NavigationView {
                HomeView()
                    .navigationBarTitle("Home", displayMode: .inline)
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
