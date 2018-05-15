//
//  Array.swift
//  StatisticsSorts
//
//  Created by Oleg Yankiwskyi on 5/10/18.
//  Copyright © 2018 Oleg Yankiwskyi. All rights reserved.
//

import Foundation

extension Array {
    static func makeList(count:Int, range: Int ) -> [Int] {
        var result: [Int] = []
        for _ in 0..<count {
            result.append(Int(arc4random_uniform(UInt32(range)) + 1))
        }
        return result
    }
}
