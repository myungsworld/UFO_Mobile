//
//  FestivalData.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/11/25.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation

struct FestivalData: Codable, Identifiable {
    
    var id = UUID()
    var festival_id: String
    var name: String
    var img_url: String
    var start_date: String
    var end_date: String
    var latitude: String
    var longitude: String
    var desc: String
    
    
}
