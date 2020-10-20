//
//  BoothTask.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation
import Combine

class StoreTask: ObservableObject {

    var data: [StoreData] = [
            StoreData(name: "booth1", icon: "boothic1"),
            StoreData(name: "booth2", icon: "boothic1"),
            StoreData(name: "booth3", icon: "boothic1"),
            StoreData(name: "booth4", icon: "boothic1"),
            StoreData(name: "booth5", icon: "boothic1"),
            StoreData(name: "booth6", icon: "boothic1"),
            StoreData(name: "booth7", icon: "boothic1"),
            StoreData(name: "booth8", icon: "boothic1"),
            StoreData(name: "booth9", icon: "boothic1"),
            StoreData(name: "booth10", icon: "boothic1"),
            StoreData(name: "booth11", icon: "boothic1"),
            StoreData(name: "booth12", icon: "boothic1"),
            StoreData(name: "booth13", icon: "boothic1"),
            StoreData(name: "booth14", icon: "boothic1"),
            StoreData(name: "booth15", icon: "boothic1")
        ] {
        
        didSet {
            objectWillChange.send()
        }
    }
    
    var grid: [Int] = [] {
        didSet {
            objectWillChange.send()
        }
    }
    
    
}
