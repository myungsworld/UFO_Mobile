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
            
            FestivallnfoVIew()
            
        }
        .onAppear {
            self.festivalTask.getFestival()
        }
    }
}

struct FestivalView_Previews: PreviewProvider {
    static var previews: some View {
        FestivalView()
    }
}
