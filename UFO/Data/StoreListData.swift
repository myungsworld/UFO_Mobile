//
//  StoreListData.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/12/05.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation

struct StoreListData: Codable, Identifiable {
    
    var id = UUID()
    var store_id: String
    var name: String
    var img_url: String
    var desc: String
}
