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
        self.name = name
        self.img_url = img_url
        self.start_time = start_time
        self.end_time = end_time
        self.latitude = latitude
        self.longitude = longitude
        self.desc = desc
        self.festival_id = festival_id
        self.etag = etag
        
    }
}
