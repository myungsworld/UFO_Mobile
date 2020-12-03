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
            
            Image("boothic1")
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
            
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
        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.3)
    }
}

struct StoreInfoView: View {
    
    @EnvironmentObject var menuTask: MenuTask
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            List(self.menuTask.menu_data) { item in
                Menu(menuData: item)
            }
            
            MapView()
                .background(Color(red: 242, green: 242, blue: 242))
                .cornerRadius(15)
                .padding(.bottom, 15)
                .padding(.leading, 15)
                .padding(.trailing, 15)
                .shadow(radius: 5)

        }.onAppear {
            print("ASD")
            print(self.menuTask.menu_data)
        }
    }
}

struct StoreInfoView_Previews: PreviewProvider {
    static var previews: some View {
        StoreInfoView()
    }
}
