//
//  BoothItemView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct StoreListItem: View {
    
    var data: StoreData
    
    var body: some View {
        
        VStack {
            Button(action: {
                
            }) {
                VStack {
                    Image(self.data.icon)
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: (UIScreen.main.bounds.width - 200) / 2, height: (UIScreen.main.bounds.height - 500) / 2)
                        .cornerRadius(50)
                    
                    Text(self.data.name)
                        .foregroundColor(Color.black)
                }
            }
        }
    }

}
