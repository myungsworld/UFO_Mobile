//
//  FestivalStoresView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/11/27.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct Store: View {
    
    let storeData: StoreListData
    
    var body: some View {
        
        NavigationLink(destination: StoreInfoView(storeId: self.storeData.store_id)) {
            
            HStack {
                
                Image("boothic1")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                
                Divider()
                
                VStack {
                    Text(storeData.name)
                        .font(.headline)
                    Text(storeData.desc)
                        .font(.title)
                }
                
                .padding()
            }
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.5), lineWidth: 1))
            .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.3)
        }
        
    }
}

struct FestivalStoresView: View {
    
    @EnvironmentObject var storeTask: StoreTask
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            List(self.storeTask.storeList) { item in
                Store(storeData: item)
            }
            
        }.onAppear {
            self.storeTask.getStoreList()
        }
    }
}

struct FestivalStoresView_Previews: PreviewProvider {
    static var previews: some View {
        FestivalStoresView()
    }
}
