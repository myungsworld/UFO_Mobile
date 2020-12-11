//
//  HomeViewBeforeLogin.swift
//  UFO
//
//  Created by myungsworld on 2020/12/09.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI
import Combine

struct HomeViewBeforeLogin: View {
    

    @Binding var selected : Int
    var body: some View {
        VStack {
            Text("이 페이지는 로그인 후 사용이 가능합니다.")
            Button( action : {
                self.selected = 2
            }) {
                Text("로그인 하러가기")
            }
            
        }
    }
}

