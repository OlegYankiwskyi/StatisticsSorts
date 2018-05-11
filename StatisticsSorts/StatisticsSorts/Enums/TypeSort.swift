//
//  TypeSorts.swift
//  StatisticsSorts
//
//  Created by Oleg Yankiwskyi on 5/10/18.
//  Copyright © 2018 Oleg Yankiwskyi. All rights reserved.
//

import Foundation

enum TypeSort: Int {
    case quick
    case insert
    case select
    case merge
    case bubble
    
    var description: String {
        get {
            switch self {
            case .quick:
                return "quick"
            case .bubble:
                return "bubble"
            case .insert:
                return "insert"
            case .select:
                return "select"
            case .merge:
                return "merge"
            }
        }
    }
}
