//
//  FestivallnfoVIew.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/11/27.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI
import KakaoSDKNavi

struct FestivallnfoVIew: View {
    
    @EnvironmentObject var festivalTask: FestivalTask
    
    let festivalCache = FestivalCache.getFesticalCache()
    
    var body: some View {
        
        ScrollView {
            VStack {
                
                Text("\(self.festivalTask.festivalData?.name ?? "Loading")")
                    .font(.largeTitle)
                
                Divider()
                
                HStack {
                    Text("\(self.festivalTask.festivalData?.start_date ?? "Loading")")
                    Text("-")
                    Text("\(self.festivalTask.festivalData?.end_date ?? "Loading")")
                }
                
                Divider()
                
                S3ImageVIew(img_url: self.festivalTask.festivalData?.img_url ?? "Loading")
                
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
                            let location = KakaoSDKNavi.NaviLocation(name: "target", x: "363792", y: "1281464")
                            guard let navigateUrl = NaviApi.shared.navigateUrl(destination: location) else {
                                return
                            }
                            UIApplication.shared.open(navigateUrl, options: [:], completionHandler: nil)
                            
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
                self.festivalTask.getFestival()
            }
        }
    }
    
}

struct FestivallnfoVIew_Previews: PreviewProvider {
    static var previews: some View {
        FestivallnfoVIew()
    }
}
