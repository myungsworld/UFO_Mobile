//
//  FestivalListData.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/11/25.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation

struct FestivalListData: Codable, Identifiable {
    
    var id = UUID()
    var festival_id: String
    var name: String
}
