//
//  BodthData.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//
import Foundation
class StoreData: Identifiable {
    
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
    
    init(store_id: String, name: String, img_url: String, start_time: String, end_time: String, latitude: String, longitude: String, desc: String, festival_id: String, etag: String) {
        
        self.store_id = store_id
        self.name = store_id
        self.img_url = store_id
        self.start_time = store_id
        self.end_time = store_id
        self.latitude = store_id
        self.longitude = store_id
        self.desc = store_id
        self.festival_id = store_id
        self.etag = store_id
        
    }
}
