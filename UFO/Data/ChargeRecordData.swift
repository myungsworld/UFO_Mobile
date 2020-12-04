//
//  ChargeRecordData.swift
//  UFO
//
//  Created by myungsworld on 2020/12/04.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI
import Combine

struct ChargeRecord : Codable, Identifiable {
    //여기에 json key 적으면 리스트 가져옴
    let id = UUID()
   
    //    var time : String
    //    var amountMoney : String
    var title : String
    var body : String
}


