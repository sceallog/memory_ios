//
//  Btn.swift
//  Memory
//
//  Created by Sven Büttner on 2024/11/14.
//

import Foundation

struct Btn {
    var hasBtnSameString = false
    var isFlipped = false
    var BtnID: Int
    
    // button identifier
    static var IDfactory = 0
    
    static func getUniqueID() -> Int {
        IDfactory += 1
        return IDfactory
    }
    
    mutating func toggleFlip() {
        isFlipped.toggle()
    }
    
    init(BtnID: Int) {
        self.BtnID = Btn.getUniqueID()
    }
}
