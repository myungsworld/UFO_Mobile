//
//  FestivalView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct FestivalView: View {
    
    var festivalIdCache = FestivalIdCache.getFestivalIdCache()
    var festivalCache = FestivalCache.getFesticalCache()
    
    var body: some View {
        
        VStack {
            // Boothes
            StoreListView()
            
            MapView()
                .background(Color(red: 242, green: 242, blue: 242))
                .cornerRadius(15)
                .padding(.bottom, 15)
                .padding(.leading, 15)
                .padding(.trailing, 15)
                .shadow(radius: 5)
                
            
        }
        .onAppear {
            let id = self.festivalIdCache.getFestivalId()
            print(id)
            
            let data = self.festivalCache.getFestival(forKey: String(id))
            print(data)
        }
    }
}

struct FestivalView_Previews: PreviewProvider {
    static var previews: some View {
        FestivalView()
    }
}
