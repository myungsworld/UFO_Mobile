//
//  SplashTask.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/11/26.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation
import Combine
import Alamofire

class SplashTask: ObservableObject {
    
    var isActive: Bool = false {
        didSet {
        
            objectWillChange.send()
        }
    }
    
    var showSelectFestivalModal: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
}
