//
//  Card.swift
//  Concentration
//
//  Created by Kevin Li on 12/23/17.
//  Copyright © 2017 Kevin Li. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false;
    var isMatched = false;
    var face: String;
    var id: Int;
    
    init(face: String) {
        self.id = Card.getUniqueID()
        self.face = face
    }
    
    static var idFac = 0
    
    static func getUniqueID() -> Int {
        idFac += 1
        return idFac
    }
    
}
