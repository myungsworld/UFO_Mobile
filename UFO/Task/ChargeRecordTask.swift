//
//  ChargeRecordTask.swift
//  UFO
//
//  Created by myungsworld on 2020/12/04.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation
import Combine


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
