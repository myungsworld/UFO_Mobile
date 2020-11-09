//
//  BoothItemView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct StoreListItem: View {
    
    var store_data: StoreData
    var grid: [Int] = []
    
    @State private var showModal = false
    
    init(store_data: StoreData) {
        self.store_data = store_data
        
//        for i in stride(from: 0, to: self.data.menu.count, by:2) {
//            if i != self.data.menu.count {
//                self.grid.append(i)
//            }
//        }
    }
    
    var body: some View {
        
        VStack {
            Button(action: {
                
//                self.showModal = true
            }) {
                VStack {
                    Image(self.store_data.url)
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: (UIScreen.main.bounds.width - 200) / 2, height: (UIScreen.main.bounds.height - 500) / 2)
                        .cornerRadius(50)
                    
                    Text(self.store_data.name)
                        .foregroundColor(Color.black)
                }
            }
//            .sheet(isPresented: self.$showModal) {
//                ModalView(data: self.data, grid: self.grid)
//            }
        }
    }
}

//struct ModalView: View {
//
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    var data: StoreData
//    var grid: [Int]
//
//    init(data: StoreData, grid: [Int]) {
//        self.data = data
//        self.grid = grid
//    }
//
//    var body: some View {
//
//        VStack(alignment: .leading, spacing: 0) {
//
//            Text("Store Info")
//                .font(.largeTitle)
//                .padding(.leading)
//
//            HStack(alignment: .top, spacing: 10) {
//                Image(self.data.url)
//                    .renderingMode(.original)
//                    .resizable()
//                    .frame(width: (UIScreen.main.bounds.width - 200) / 2, height: (UIScreen.main.bounds.height - 500) / 2)
//                    .cornerRadius(50)
//                    .padding(.leading)
//
//                Spacer()
//
//                Text(self.data.name)
//                    .foregroundColor(Color.black)
//                    .padding(.trailing, 100)
//            }
//            .frame(width: (UIScreen.main.bounds.width - 50), height: (UIScreen.main.bounds.height) / 5)
//            .background(Color(red: 242, green: 242, blue: 242))
//            .cornerRadius(15)
//            .padding(.top)
//            .padding(.leading, 20)
//            .padding(.trailing, 20)
//            .shadow(radius: 5)
//
//            Text("Menu")
//                .font(.largeTitle)
//                .padding(.leading)
//                .padding(.top)
//
//            ScrollView(.horizontal, showsIndicators: false) {
//
//                HStack(spacing: 25) {
//                    ForEach(self.grid, id: \.self) { i in
//
//                        VStack(spacing: 15) {
//                            ForEach((i...i+1), id: \.self) { j in
//
//                                VStack {
//                                    if j != self.data.menu.count {
//                                        VStack {
//                                            Text(self.data.menu[j].name)
//                                            .font(.title)
//                                            Image(self.data.menu[j].url)
//                                                .renderingMode(.original)
//                                                .resizable()
//                                                .frame(width: (UIScreen.main.bounds.width - 200) / 2, height: (UIScreen.main.bounds.height - 500) / 2)
//                                                .cornerRadius(50)
//
//                                            Text(String(self.data.menu[j].price))
//                                                .font(.subheadline)
//
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//            .frame(width: (UIScreen.main.bounds.width - 50), height: (UIScreen.main.bounds.height) / 2)
//            .background(Color(red: 242, green: 242, blue: 242))
//            .cornerRadius(15)
//            .padding(.top)
//            .padding(.leading, 20)
//            .padding(.trailing, 20)
//            .shadow(radius: 5)
//        }
//        .padding(.top, -(UIScreen.main.bounds.height / 30) )
//
//    }
//}

//struct ModalView_Previews: PreviewProvider {
//    static var previews: some View {
//        ModalView(data: StoreData(name: "booth1", url: "boothic1", menu: ["asd" : "123"]))
//    }
//}
