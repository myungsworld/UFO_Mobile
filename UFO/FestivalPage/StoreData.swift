//
//  BodthData.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

struct StoreData: Codable {
    
    var name: String
    var url: String
    var menu: [StoreMenuData]
}
