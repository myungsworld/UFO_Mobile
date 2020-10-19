//
//  SignupData.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/20.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

struct SignupData: Codable {
    
    var email: String
    var pw: String
    var name: String
    var userphone: String
    
    init(email: String, pw: String, name: String, userphone: String) {
        self.email = email
        self.pw = pw
        self.name = name
        self.userphone = userphone
    }
}
