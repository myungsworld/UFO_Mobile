//
//  SplashView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct SplashView: View {
    
    @EnvironmentObject var festivalTask: FestivalTask
    @EnvironmentObject var splashTask: SplashTask
    let festivalIdCache = FestivalIdCache.getFestivalIdCache()
    let festivalCache = FestivalCache.getFesticalCache()
    
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

//                self.festivalIdCache.removeFile()
                let festival_id = self.festivalIdCache.getFestivalId()
//                self.festivalCache.removeFromFile(forKey: String(festival_id))

                if festival_id == -1 {

                    self.festivalTask.getFestivalList()

                    withAnimation {
                        self.splashTask.show.toggle()
                    }
                    
                    return
                    
                } else {
                    
                    // FestivalCache Task 합치기
                    // http 통신 전 확인하기
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        //Festival 정보 가져오기
                        self.festivalTask.getFestival()
                        self.splashTask.isActive.toggle()
                    }
                }
            }
            
            if self.splashTask.show {

                GeometryReader{ gp in

                    FestivalListPopUpView()
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
