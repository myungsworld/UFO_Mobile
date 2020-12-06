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
            setFestivalId()
        }) {
            VStack {
                
                Text(festivalListData.name)
                
            }.padding()
        }
    }
    
    func setFestivalId() {
        
        let selected_festival_id = Int(festivalListData.festival_id)!
        self.festivalIdCache.setFetivalId(festival_id: selected_festival_id)
        
        withAnimation {
            self.splashTask.showSelectFestivalModal.toggle()
        }

        self.festivalTask.getFestival()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {

            self.splashTask.isActive.toggle()
        }
    }
}

struct FestivalListPopUpView: View {

    @EnvironmentObject var festivalTask: FestivalTask
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            List(self.festivalTask.festivalList) { item in
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
