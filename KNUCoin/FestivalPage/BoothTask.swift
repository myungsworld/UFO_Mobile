//
//  BoothTask.swift
//  KNUCoin
//
//  Created by Sanghyun Byun on 2020/10/06.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation
import Combine

class BoothTask: ObservableObject {

    var data: [BoothData] = [
            BoothData(name: "booth1", icon: "boothic1"),
            BoothData(name: "booth2", icon: "boothic1"),
            BoothData(name: "booth3", icon: "boothic1"),
            BoothData(name: "booth4", icon: "boothic1"),
            BoothData(name: "booth5", icon: "boothic1"),
            BoothData(name: "booth6", icon: "boothic1"),
            BoothData(name: "booth7", icon: "boothic1"),
            BoothData(name: "booth8", icon: "boothic1"),
            BoothData(name: "booth9", icon: "boothic1"),
            BoothData(name: "booth10", icon: "boothic1"),
            BoothData(name: "booth11", icon: "boothic1"),
            BoothData(name: "booth12", icon: "boothic1"),
            BoothData(name: "booth13", icon: "boothic1"),
            BoothData(name: "booth14", icon: "boothic1"),
            BoothData(name: "booth15", icon: "boothic1")
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

