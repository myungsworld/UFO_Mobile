//
//  BodthData.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//
import Foundation
struct StoreData: Codable, Identifiable {
    
    var id = UUID()
    var store_id: String
    var name: String
    var img_url: String
    var start_time: String
    var end_time: String
    var latitude: String
    var longitude: String
    var desc: String
    var festival_id: String
    var etag: String
}
