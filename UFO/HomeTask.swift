//
//  HomeTask.swift
//  UFO
//
//  Created by myungsworld on 2020/11/30.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation
import Combine

class HomeTask : ObservableObject {
    
    var pay : Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
    
    var click : Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
}
