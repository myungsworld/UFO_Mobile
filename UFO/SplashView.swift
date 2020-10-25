//
//  SplashView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct SplashView: View {
    
    
    @State var isActice:Bool = false
    @State var show = false
    @EnvironmentObject var storeTask: StoreTask
    
    var festivalIdCache = FestivalIdCache.getFestivalIdCache()
    
    var body: some View {
        
        ZStack {
            VStack {
                if self.isActice {
                    MainView()
                    //                    KakaoLoginView()
                } else {
                    Text("UFO")
                        .font(Font.largeTitle)
                    
                    Text("Univ Festival in One")
                    
                }
                
            }.onAppear {
                
                // Cache hit 못할 떄
                guard let f_id = self.festivalIdCache.get(forKey: "f_id") else {
                    print("Cache miss")
                    
                    let fileManagerHandler = FileManagerHandler(filename: "f_id")
            
                    // File에 없을 때
                    if !fileManagerHandler.fileExists() {
                        print("none")
                        
                        // Pop up 띄우기
                        withAnimation {
                            self.show = true
                        }
                        
                        return
                        
                    } else {
                    // File에 있을 때
                        let f_id = fileManagerHandler.getFileText()
                        self.festivalIdCache.set(forKey: "f_id", id: Int(f_id)!)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            
                            withAnimation {
                                // Load Stores info
                                self.storeTask.getStoreInfo(f_id: Int(f_id)!)
                                
                                self.isActice.toggle()
                            }
                        }
                        
                        return
                    }
                    
                }
                
                // Cache hit 했을 때
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    
                    withAnimation {
                        // Load Stores info
                        self.storeTask.getStoreInfo(f_id: Int(f_id))
                        
                        self.isActice.toggle()
                    }
                }
            }
            
            if self.show {
                
                GeometryReader{ _ in
                    
                    FestivalList(isActive: self.$isActice, show: self.$show)
                }.background(
                    Color.black.opacity(0.65)
                        .edgesIgnoringSafeArea(.all)
                    
                )
            }
        }
    }
}

struct FestivalList: View {
    
    @Binding var isActive: Bool
    @Binding var show: Bool
    
    @EnvironmentObject var storeTask: StoreTask
    
    var festivalIdCache = FestivalIdCache.getFestivalIdCache()
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 15) {
            
            Button(action: {
                
                self.cacheFestivalId(f_id: 1)
                
            }) {
                Text("1")
                    .frame(width: 38, height: 28)
                    .foregroundColor(.black)
            }
            
            Button(action: {
                
                self.cacheFestivalId(f_id: 2)
                
            }) {
                Text("2")
                    .frame(width: 38, height: 28)
                    .foregroundColor(.black)
            }
            
            Button(action: {
                
                self.cacheFestivalId(f_id: 3)
                
            }) {
                Text("3")
                    .frame(width: 38, height: 28)
                    .foregroundColor(.black)
            }
        }.padding()
            .background(Color.gray)
            .cornerRadius(15)
    }
    
    func cacheFestivalId(f_id: Int) {
        // Cache에도 없고 File에도 없고
        self.festivalIdCache.set(forKey: "f_id", id: f_id)
        
        let fileManagerHandler = FileManagerHandler(filename: "f_id")
        fileManagerHandler.setFileText(str: String(f_id))
        
        withAnimation {
            self.show = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            
            withAnimation {
                // Load Stores info
                self.storeTask.getStoreInfo(f_id: f_id)
                
                self.isActive.toggle()
            }
        }
    }
}

//struct SplashView_Previews: PreviewProvider {
//    static var previews: some View {
//        FestivalList()
//    }
//}
