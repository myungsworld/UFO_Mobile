//
//  BoothView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct StoreListView: View {
    
    @EnvironmentObject var storeTask: StoreTask
    
    var body: some View {
        
        VStack {
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 25) {
                    ForEach(self.storeTask.grid, id: \.self) { i in
                        
                        VStack(spacing: 15) {
                            ForEach((i...i+1), id: \.self) { j in
                                
                                VStack {
                                    if j != self.storeTask.store_data.count {
                                        StoreListItem(store_data: self.storeTask.store_data[j])
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

struct StoreListView_Previews: PreviewProvider {
    static var previews: some View {
        StoreListView()
    }
}
