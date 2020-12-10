//
//  MyPageView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct MyPageView: View {
    
    @EnvironmentObject var userTask: UserTask
    
    var body: some View {
        
        if (!self.userTask.isLogin) {
            
            NotLogedinView()
        } else {
            
            LogedinView()
        }    
    }
}
