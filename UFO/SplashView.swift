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
                    
                } else {
                    Text("UFO")
                        .font(Font.largeTitle)
                    
                    Text("Univ Festival in One")
                }
                
            }.onAppear {
                
//                self.festivalIdCache.removeFile()
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
                        self.storeTask.getStoreInfo(festival_id: festival_id)
                        
                        self.isActice.toggle()
                    }
                }
            }
            
            if self.show {
                
                GeometryReader{ _ in
                    
                    FestivalListPopUpView(isActive: self.$isActice, show: self.$show)
                }.background(
                    Color.black.opacity(0.65)
                        .edgesIgnoringSafeArea(.all)
                    
                )
            }
        }
    }
}

//struct SplashView_Previews: PreviewProvider {
//    static var previews: some View {
//        FestivalList()
//    }
//}
