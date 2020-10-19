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
    @EnvironmentObject var boothTask: BoothTask
    
    var body: some View {
        
        VStack {
            if self.isActice {
                MainView()
            } else {
                Text("UFO")
                    .font(Font.largeTitle)
                
                Text("Univ Festival in One")
            }
            
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                
                // Load Boothes
                for i in stride(from: 0, to: self.boothTask.data.count, by: 2){
                    if i != self.boothTask.data.count{
                        self.boothTask.grid.append(i)
                    }
                }
            
                withAnimation {
                    self.isActice = true
                }
            }
        }
        
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
