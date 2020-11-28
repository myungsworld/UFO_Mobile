//
//  FestivalView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct FestivalView: View {
    
    @EnvironmentObject var festivalTask: FestivalTask
    let festivalIdCache = FestivalIdCache.getFestivalIdCache()
    
    var body: some View {
        
        VStack {
            
            switch self.festivalTask.festivalView_mode {
            
            case 0:
                FestivallnfoVIew()
                
            case 1:
                FestivalStoresView()
                
            default:
                FestivallnfoVIew()
            }
        }
        .onAppear {
            let festival_id = self.festivalIdCache.getFestivalId()
            self.festivalTask.getFestivalWithURL(festival_id: festival_id)
        }
    }
}

struct FestivalView_Previews: PreviewProvider {
    static var previews: some View {
        FestivalView()
    }
}
