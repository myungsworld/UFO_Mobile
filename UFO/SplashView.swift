//
//  SplashView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct SplashView: View {
    
    @EnvironmentObject var storeTask: StoreTask
    @EnvironmentObject var festivalTask: FestivalTask
    @EnvironmentObject var splashTask: SplashTask
    let festivalIdCache = FestivalIdCache.getFestivalIdCache()
    
    @State var isActive: Bool = false
    @State var show: Bool = false
    
    var body: some View {
        
        ZStack {
            VStack {
                if self.splashTask.isActive {
                    MainView()
                    
                } else {
                    Text("UFO")
                        .font(Font.largeTitle)
                    
                    Text("Univ Festival in One")
                }
                
            }.onAppear {

                self.festivalIdCache.removeFile()
                var festival_id = self.festivalIdCache.getFestivalId()
                print(festival_id)
                
                if festival_id == -1 {

                    self.festivalTask.getFestivalList()

                    withAnimation {
                        self.splashTask.show.toggle()
                    }
                    
                    return
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    //Festival 정보 가져오기
                    festival_id = self.festivalIdCache.getFestivalId()
                    print(festival_id)
                    
                }
                
                
                
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
//                    withAnimation {
//                        // Load Stores info
//                        self.storeTask.getStoreInfo(festival_id: festival_id)
//
//                        self.isActice.toggle()
//                    }
//                }
            }
            
            if self.splashTask.show {

                GeometryReader{ gp in

                    FestivalListPopUpView(isActive: self.$splashTask.isActive, show: self.$splashTask.show)
                }
                .padding()
                .background(Color.gray)
                .cornerRadius(15)
                .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.9)
            }
        }
    }
}

//struct SplashView_Previews: PreviewProvider {
//    static var previews: some View {
//        FestivalList()
//    }
//}
