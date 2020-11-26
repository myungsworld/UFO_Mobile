//
//  FestivalListPopUpView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/28.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct FestivalList: View {
    
    var festivalListData: FestivalListData
    var festivalIdCache = FestivalIdCache.getFestivalIdCache()
    @EnvironmentObject var festivalTask: FestivalTask
    @EnvironmentObject var splashTask: SplashTask
    
    var body: some View {
    
        Button(action: {
            var selected_festival_id = Int(festivalListData.festival_id)!
            
            self.festivalIdCache.setFetivalId(festival_id: selected_festival_id)
            
            print(self.festivalIdCache.getFestivalId())
            
            withAnimation {
                self.splashTask.show.toggle()
            }
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//
//                self.splashTask.isActive.toggle()
//            }
            
        }) {
            HStack {
                Text(festivalListData.name)
                Image("boothic1")
                    .resizable()
                    .frame(width: 100, height: 100)
            }.padding()
        }
    }
    
}

struct FestivalListPopUpView: View {
    
    @Binding var isActive: Bool
    @Binding var show: Bool
    @EnvironmentObject var festivalTask: FestivalTask
    var festivalIdCache = FestivalIdCache.getFestivalIdCache()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            List(self.festivalTask.festival_list) { item in
                FestivalList(festivalListData: item)
            }
            
        }
    }
    
    func setFestivalId(festival_id: Int) {
        self.festivalIdCache.setFetivalId(festival_id: festival_id)
        
        withAnimation {
            self.show = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            
            withAnimation {
                // Load Stores info
//                self.storeTask.getStoreInfo(festival_id: festival_id)
                self.isActive.toggle()
            }
        }
    }
}

//struct FestivalListPopUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        FestivalListPopUpView()
//    }
//}
