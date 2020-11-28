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
    var festivalCache = FestivalCache.getFesticalCache()
    
    @EnvironmentObject var festivalTask: FestivalTask
    @EnvironmentObject var splashTask: SplashTask
    
    var body: some View {
    
        Button(action: {
            test()
        }) {
            HStack {
                Text(festivalListData.name)
                Image("boothic1")
                    .resizable()
                    .frame(width: 100, height: 100)
            }.padding()
        }
    }
    
    func test() {
        
        let selected_festival_id = Int(festivalListData.festival_id)!
        
        self.festivalIdCache.setFetivalId(festival_id: selected_festival_id)
        
        withAnimation {
            self.splashTask.show.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
        
            var festival_id = self.festivalIdCache.getFestivalId()
            
            //Festival 정보 가져오기
            // 먼저 Cache와 File에 있는지 확인
            let festival = self.festivalCache.getFestival(forKey: String(festival_id))
            
            if festival == nil {
                // Cache 및 File에 없을때
                self.festivalTask.getFestival()
            }
            
            self.splashTask.isActive.toggle()
        }
    }
}

struct FestivalListPopUpView: View {

    @EnvironmentObject var festivalTask: FestivalTask
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            List(self.festivalTask.festival_list) { item in
                FestivalList(festivalListData: item)
            }
        }
    }
}

//struct FestivalListPopUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        FestivalListPopUpView()
//    }
//}
