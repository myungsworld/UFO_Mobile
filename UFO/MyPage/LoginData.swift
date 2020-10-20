//
//  LoginData.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

struct LoginData: Codable {
    var email: String
    var pw: String
    
    init(email: String, pw: String) {
        self.email = email
        self.pw = pw
    }
}