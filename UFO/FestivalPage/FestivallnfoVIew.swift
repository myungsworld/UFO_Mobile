//
//  FestivallnfoVIew.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/11/27.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct FestivallnfoVIew: View {
    
    @EnvironmentObject var festivalTask: FestivalTask
    @EnvironmentObject var storeTask: StoreTask
    
    let festivalCache = FestivalCache.getFesticalCache()
    
    var body: some View {
        
        ScrollView {
            VStack {
                
                Text("\(self.festivalTask.festivalData!.name)")
                    .font(.largeTitle)
                
                Divider()
                
                HStack {
                    Text("\(self.festivalTask.festivalData!.start_date)")
                    Text("-")
                    Text("\(self.festivalTask.festivalData!.end_date)")
                }
                
                Divider()
                
                S3ImageVIew(img_url: "5EFADC67-A4C8-43A8-BF19-CB621D8C8FF3.jpeg",
                            width: UIScreen.main.bounds.width * 0.9,
                            height: UIScreen.main.bounds.height * 0.8)
                
                Divider()
                
                HStack {
                    
                    NavigationLink(destination: FestivalStoresView()) {
                        
                        Image("boothic1")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.2)
                            .cornerRadius(50)
                    }
                    
                    Button(action: {
                        withAnimation {
//                            self.festivalTask.festivalView_mode = 2
                        }
                    }) {
                        Image("boothic1")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.2)
                            .cornerRadius(50)
                    }
                }
            }.onAppear {
                self.storeTask.getStores()
            }
        }
    }
    
}

struct FestivallnfoVIew_Previews: PreviewProvider {
    static var previews: some View {
        FestivallnfoVIew()
    }
}
