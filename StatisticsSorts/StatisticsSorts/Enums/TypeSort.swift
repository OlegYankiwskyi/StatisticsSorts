//
//  TypeSorts.swift
//  StatisticsSorts
//
//  Created by Oleg Yankiwskyi on 5/10/18.
//  Copyright © 2018 Oleg Yankiwskyi. All rights reserved.
//

import Foundation

enum TypeSort {
    case quick
    case bubble
    case insert
    case select
    case merge
    
    init(rawValue: Int) {
        switch rawValue {
        case 0:
            self = .quick
        case 1:
            self = .bubble
        case 2:
            self = .insert
        case 3:
            self = .select
        case 4:
            self = .merge
        default:
            self = .quick //TO DO
        }
    }
    
    var rawValue: Int {
        get {
            switch self {
            case .quick:
                return 0
            case .bubble:
                return 1
            case .insert:
                return 2
            case .select:
                return 3
            case .merge:
                return 4
            }
        }
    }
    
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
