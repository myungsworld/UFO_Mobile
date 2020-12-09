//
//  StoreInfoView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/12/01.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct Menu: View {
    
    let menuData: MenuData
    
    var body: some View {
        HStack {
            
            
            S3ImageVIew(img_url: self.menuData.img_url)
                .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.15)
                .cornerRadius(10)
                .padding()        
            
            Divider()
            
            VStack {
                Text(self.menuData.name)
                    .font(.headline)
                Text(self.menuData.price)
                    .font(.title)
            }
            
            .padding()
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.5), lineWidth: 1))
    }
}

struct StoreInfoView: View {
    
    @EnvironmentObject var storeTask: StoreTask
    var storeId: String
    
    init(storeId: String) {
        self.storeId = storeId
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            List(self.storeTask.menuList) { item in
                Menu(menuData: item)
            }
            
            
            if self.storeTask.showMap {
                
                let data = self.storeTask.storeData!
                
                MapView(lat: data.latitude, lon: data.longitude)
                    .background(Color(red: 242, green: 242, blue: 242))
                    .cornerRadius(15)
                    .padding(.bottom, 15)
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
                    .shadow(radius: 5)
            }

        }.onAppear {
            
            self.storeTask.getStore(store_id: self.storeId)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    self.storeTask.showMap.toggle()
                }
            }
        }
    }
}
