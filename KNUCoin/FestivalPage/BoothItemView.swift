//
//  BoothItemView.swift
//  KNUCoin
//
//  Created by Sanghyun Byun on 2020/10/06.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct BoothItemView: View {
    
    var data: BoothData
    
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
