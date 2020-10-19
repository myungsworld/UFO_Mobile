//
//  FestivalView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct FestivalView: View {
    
    var body: some View {
        
        VStack {
            // Boothes
            BoothView()
            
            VStack {
                MapView()
                
                .background(Color(red: 242, green: 242, blue: 242))
                .cornerRadius(15)
                .padding(.bottom, 15)
                .padding(.leading, 15)
                .padding(.trailing, 15)
                .shadow(radius: 5)
                
            }
        }
    }
}

struct FestivalView_Previews: PreviewProvider {
    static var previews: some View {
        FestivalView()
    }
}
