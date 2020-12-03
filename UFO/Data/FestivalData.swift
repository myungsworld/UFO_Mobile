//
//  FestivalData.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/11/25.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation

class FestivalData: Identifiable {
    
    var id = UUID()
    var festival_id: String
    var name: String
    var img_url: String
    var start_date: String
    var end_date: String
    var latitude: String
    var longitude: String
    var desc: String
    var etag: String
    
    init(festival_id: String, name: String, img_url: String, start_date: String, end_date: String, latitude: String, longitude: String, desc: String, etag: String) {
        
        self.festival_id = festival_id
        self.name = name
        self.img_url = img_url
        self.start_date = start_date
        self.end_date = end_date
        self.latitude = latitude
        self.longitude = longitude
        self.desc = desc
        self.etag = etag
    }

    
    
}
