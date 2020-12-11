//
//  Data.swift
//  UFO
//
//  Created by myungsworld on 2020/12/04.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct Post : Codable, Identifiable {
    let id = UUID()
    var title : String
    var body : String
}

class Api {
    func getPosts() {
        let url = URL(string : "")
    }
}
