//
//  TimeStatistics.swift
//  StatisticsSorts
//
//  Created by Oleg Yankiwskyi on 5/10/18.
//  Copyright © 2018 Oleg Yankiwskyi. All rights reserved.
//

import Foundation

class TimeStatistics {
    
    func timeSort(typeSort: TypeSort, array: [Int]) -> Double {
        let sorter = Sorter()
        
        switch typeSort {
        case .quick:
            let now = Date()
            let _ = sorter.quickSort(array: array)
            return -now.timeIntervalSinceNow
        case .bubble:
            let now = Date()
            let _ = sorter.bubbleSort(array: array)
            return -now.timeIntervalSinceNow
        case .insert:
            let now = Date()
            let _ = sorter.insertSort(array: array)
            return -now.timeIntervalSinceNow
        case .select:
            let now = Date()
            let _ = sorter.selectSort(array: array)
            return -now.timeIntervalSinceNow
        case .merge:
            let now = Date()
            let _ = sorter.mergeSort(array: array)
            return -now.timeIntervalSinceNow
        }
    }
}
