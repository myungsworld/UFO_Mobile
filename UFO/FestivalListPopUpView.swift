//
//  FestivalListPopUpView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/28.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct FestivalListPopUpView: View {
    
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
                self.storeTask.getStoreInfo(festival_id: festival_id)
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
