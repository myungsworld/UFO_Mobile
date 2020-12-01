//
//  MenuData.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/11/25.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation
struct MenuData: Codable, Identifiable {
    
    var id = UUID()
    var menu_id: String
    var name: String
    var price: String
    var img_url: String
    var store_id: String
    var etag: String
}
