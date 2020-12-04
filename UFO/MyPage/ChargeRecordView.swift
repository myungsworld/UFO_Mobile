//
//  ChargeRecord.swift
//  UFO
//
//  Created by myungsworld on 2020/12/04.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI
import Combine


struct ChargeRecordView : View {
    
//    @EnvironmentObject var chargeTask : ChargeTask
//    @EnvironmentObject var ChargeRecordData : ChargeRecordData
    @State var chargeRecords : [ChargeRecord] = []
    var body : some View {
        List(chargeRecords) { record in
            Text(record.title)
        }
        .onAppear {
            ChargeRecordData().getData { (k) in
                self.chargeRecords = k
            }
        }
        
    }
}
