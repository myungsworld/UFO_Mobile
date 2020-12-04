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
    let id = UUID()
    //여기에 json key 적으면 리스트 가져옴
//    var time : String
//    var amountMoney : String
    var title : String
    var body : String
}

class ChargeRecordData  {
    func getData(completion : @escaping ([ChargeRecord]) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _,_) in
            let ChargeRecords = try! JSONDecoder().decode([ChargeRecord].self, from : data!)
//            print(ChargeRecords)
            DispatchQueue.main.async {
                completion(ChargeRecords)
            }
        }
        .resume()
    }
}
//var chargeRecord : [ChargeRecord] = [
//    ChargeRecord(time: "시간이 여기에 들어가야겠지" , amountMoney: "1000"),
//    ChargeRecord(time: "야야야야 위리빙인어 디프런 타임존" , amountMoney: "2000")
//]
