//
//  Card.swift
//  DeckOfOneCard
//
//  Created by Bryan Workman on 6/16/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import Foundation

struct Card: Decodable {
    var value: String
    var suit: String
    var image: URL
    
}
struct TopLevelObject: Decodable {
       var cards: [Card]
   }
