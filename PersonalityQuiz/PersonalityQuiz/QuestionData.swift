//
//  QuwstionData.swift
//  PersonalityQuiz
//
//  Created by henry on 28/05/2019.
//  Copyright © 2019 HenryNguyen. All rights reserved.
//

import Foundation

struct Question {
    var text : String
    var type : ResponseType
    var answer : [Answer]
}

struct Answer {
    var text : String
    var type : AnimalType
}

enum ResponseType {
    case single, multiple, ranged
}

enum AnimalType : Character {
//    case dog = "🐶", cat = "🐱", rabbit = "🐰", turtle = "🐢”
    
    case dog = "d", cat = "c", rabbit = "r", turtle = "t"

    var definition : String {
        switch self {
        case .dog:
            return "Outgoing"
        case .cat:
            return "Doing things on your own term"
        case .rabbit:
            return "healthy and full of energy"
        case .turtle:
            return "Slow and steady win the race"
        }
    }
}


