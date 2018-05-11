//
//  DataModel.swift
//  StatisticsSorts
//
//  Created by Oleg Yankiwskyi on 5/11/18.
//  Copyright © 2018 Oleg Yankiwskyi. All rights reserved.
//

import Foundation

class DataModel {
    let data = [
        "1000"  :  Array<Int>.makeList(count: 1000, range: 999)
        ,"2000"  :  Array<Int>.makeList(count: 2000, range: 999)
        ,"4000"  :  Array<Int>.makeList(count: 4000, range: 999)
        ,"8000"  :  Array<Int>.makeList(count: 8000, range: 999)
        ,"16000" :  Array<Int>.makeList(count: 16000,range: 999)
    ]
    
    var count: Int {
        return data.count
    }
}
