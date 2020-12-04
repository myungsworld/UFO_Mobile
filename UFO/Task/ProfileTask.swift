//
//  ProfileTask.swift
//  UFO
//
//  Created by myungsworld on 2020/12/04.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation
import Combine

class ProfileTask : ObservableObject {
    var switchToChargeRecordView : Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
}
