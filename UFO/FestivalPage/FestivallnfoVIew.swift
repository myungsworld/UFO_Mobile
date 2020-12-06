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
                print("B")
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
