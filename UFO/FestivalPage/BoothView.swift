//
//  BoothView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct BoothView: View {
    
    @EnvironmentObject var boothTask: BoothTask
       
       var body: some View {
    
           VStack {

               ScrollView(.horizontal, showsIndicators: false) {

                   HStack(spacing: 25) {
                       
                       ForEach(self.boothTask.grid, id: \.self) { i in
                           
                           VStack(spacing: 15) {
                               
                               ForEach((i...i+1), id: \.self) { j in
                                   
                                   VStack {
                                       if j != self.boothTask.data.count {
                                           BoothItemView(data: self.boothTask.data[j])
                                       }
                                   }
                               }
                               
                           }
                       }
                       
                   }
                   .padding()
               }
               .background(Color(red: 242, green: 242, blue: 242))
               .cornerRadius(15)
               .padding(15)
               .shadow(radius: 5)
               
               
           }
       }
}

struct BoothView_Previews: PreviewProvider {
    static var previews: some View {
        BoothView()
    }
}
