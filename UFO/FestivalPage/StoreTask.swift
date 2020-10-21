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
        StoreData(name: "booth1", url: "boothic1", menu: [StoreMenuData(name: "menu1", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu2", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu3", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu6", price: 10000, url: "boothic1"),]),
        
        StoreData(name: "booth2", url: "boothic1", menu: [StoreMenuData(name: "menu1", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu2", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu3", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu4", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu4", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu5", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu6", price: 10000, url: "boothic1"),]),
        
        StoreData(name: "booth3", url: "boothic1", menu: [StoreMenuData(name: "menu1", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu2", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu3", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu4", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu5", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu6", price: 10000, url: "boothic1"),]),
        
        StoreData(name: "booth4", url: "boothic1", menu: [StoreMenuData(name: "menu1", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu2", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu5", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu6", price: 10000, url: "boothic1"),]),
        
        StoreData(name: "booth5", url: "boothic1", menu: [StoreMenuData(name: "menu1", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu2", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu3", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu4", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu5", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu6", price: 10000, url: "boothic1"),]),
        
        StoreData(name: "booth6", url: "boothic1", menu: [StoreMenuData(name: "menu1", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu4", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu5", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu6", price: 10000, url: "boothic1"),]),
        
        StoreData(name: "booth7", url: "boothic1", menu: [StoreMenuData(name: "menu1", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu2", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu3", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu4", price: 10000, url: "boothic1")]),
        
        StoreData(name: "booth8", url: "boothic1", menu: [StoreMenuData(name: "menu1", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu2", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu3", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu6", price: 10000, url: "boothic1")]),
        
        StoreData(name: "booth9", url: "boothic1", menu: [StoreMenuData(name: "menu1", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu2", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu3", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu4", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu5", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu6", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu4", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu5", price: 10000, url: "boothic1"),
                                                          StoreMenuData(name: "menu6", price: 10000, url: "boothic1")]),
        
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
