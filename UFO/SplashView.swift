//
//  SplashView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI
import UIKit

struct SplashView: View {
    
    @EnvironmentObject var festivalTask: FestivalTask
    @EnvironmentObject var splashTask: SplashTask
    @EnvironmentObject var userTask: UserTask
    
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
                
                if festival_id == -1 {
                    
//                    self.festivalTask.getFestivalList()
                    
                    withAnimation {
                        self.splashTask.showSelectFestivalModal.toggle()
                    }
                    
                    return
                    
                }
                
                // 카카오 로그인이 되어있는 상태인지 확인 하기 위해
                self.userTask.me()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        self.splashTask.isActive.toggle()
                    }
                }
                
            }
            
            if self.splashTask.showSelectFestivalModal {
                
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

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

//struct SplashView_Previews: PreviewProvider {
//    static var previews: some View {
//        FestivalList()
//    }
//}
