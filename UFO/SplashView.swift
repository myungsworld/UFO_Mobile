//
//  SplashView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct SplashView: View {
    
    
    @State var isActice:Bool = false
    @State var show = false
    @EnvironmentObject var storeTask: StoreTask
    
    var festivalIdCache = FestivalIdCache.getFestivalIdCache()
    
    var body: some View {
        
        ZStack {
            VStack {
                if self.isActice {
                    MainView()
                    //                    KakaoLoginView()
                } else {
                    Text("UFO")
                        .font(Font.largeTitle)
                    
                    Text("Univ Festival in One")
                }
                
            }.onAppear {
                
                let festival_id = self.festivalIdCache.getFestivalId()
                
                if festival_id == -1 {
                    withAnimation {
                        self.show = true
                    }
                    
                    return
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        // Load Stores info
                        self.storeTask.getStoreInfo(f_id: festival_id)
                        
                        self.isActice.toggle()
                    }
                }
            }
            
            if self.show {
                
                GeometryReader{ _ in
                    
                    FestivalList(isActive: self.$isActice, show: self.$show)
                }.background(
                    Color.black.opacity(0.65)
                        .edgesIgnoringSafeArea(.all)
                    
                )
            }
        }
    }
}

struct FestivalList: View {
    
    @Binding var isActive: Bool
    @Binding var show: Bool
    
    @EnvironmentObject var storeTask: StoreTask
    
    var festivalIdCache = FestivalIdCache.getFestivalIdCache()
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 15) {
            
            Button(action: {
                
                self.setFestivalId(festival_id: 1)
                
            }) {
                Text("1")
                    .frame(width: 38, height: 28)
                    .foregroundColor(.black)
            }
            
            Button(action: {
                
                self.setFestivalId(festival_id: 2)
                
            }) {
                Text("2")
                    .frame(width: 38, height: 28)
                    .foregroundColor(.black)
            }
            
            Button(action: {
                
                self.setFestivalId(festival_id: 3)
                
            }) {
                Text("3")
                    .frame(width: 38, height: 28)
                    .foregroundColor(.black)
            }
        }.padding()
            .background(Color.gray)
            .cornerRadius(15)
    }
    
    func setFestivalId(festival_id: Int) {
        self.festivalIdCache.setFetivalId(festival_id: festival_id)
        
        withAnimation {
            self.show = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            
            withAnimation {
                // Load Stores info
                self.storeTask.getStoreInfo(f_id: festival_id)
                
                self.isActive.toggle()
            }
        }
    }
}

//struct SplashView_Previews: PreviewProvider {
//    static var previews: some View {
//        FestivalList()
//    }
//}
