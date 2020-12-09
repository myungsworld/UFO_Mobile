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
                                
                S3ImageVIew(img_url: self.storeData.img_url)
                    .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.15)
                    .cornerRadius(10)
                    .padding()
                
                Divider()
                
                VStack {
                    Text(storeData.name)
                        .font(.headline)
                    Text(storeData.desc)
                        .font(.title)
                }
                .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.height * 0.15)
                .padding()
            }
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.5), lineWidth: 1))
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
            self.storeTask.showMap = false
            self.storeTask.getStoreList()
        }
    }
}

struct FestivalStoresView_Previews: PreviewProvider {
    static var previews: some View {
        FestivalStoresView()
    }
}
