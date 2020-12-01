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
    @State private var money = ""
    @EnvironmentObject var http : HttpAuth
    
    var body: some View {
        
        TabView(selection: $selected) {
            
            // Home
            ZStack  {
                NavigationView {
                    HomeView()
                        .navigationBarTitle("Home", displayMode: .inline)
                        .navigationBarItems(trailing: Button(action : {
                            withAnimation {
                            self.isPresented.toggle()
                            }
                        }, label: {
                            Text("충전")
                        }))

                        
                }
                
                ZStack {
                    HStack{
                        Spacer()
                        VStack {
                            Spacer()
                            TextField("충전 금액", text : $money)
                                .keyboardType(.numberPad)
                                .font(.title)
                                .padding([.horizontal, .bottom])
                            Button(action: {
                                withAnimation{
                                    self.http.chargeMoney(id: "myung", org: "SalesOrg", amount: money)
                                    self.isPresented.toggle()
                                }
                            }, label : {
                                Text("충전")
                            })
                            Button(action: {
                                withAnimation{
                                    
                                    self.isPresented.toggle()
                                }
                            }, label: {
                                    Text("뒤로가기")
                                })
                            .offset(x: 150 ,y : -400)
                            Spacer()
                        }
                        Spacer()
                    }

                }
                
                .background(Color.white)
                    .edgesIgnoringSafeArea(.all)
                .offset(x: 0 , y: self.isPresented ? 0 : UIApplication.shared.keyWindow?.frame.height ?? 0)
            }
            .gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
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
