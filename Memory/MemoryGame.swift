//
//  MemoryGame.swift
//  Memory
//
//  Created by Sven Büttner on 2024/11/14.
//

import Foundation

class MemoryGame {
    var buttons = [Btn]()
    
    func chooseBtn(at index: Int) {
        if buttons[index].isBtnWhite {
            buttons[index].isBtnWhite = false
        } else {
            buttons[index].isBtnWhite = true
        }
    }
    
    init(NumOfBtnPairs: Int) {
        for BtnID in 0..<NumOfBtnPairs {
            let btn = Btn(BtnID: BtnID)
            buttons += [btn, btn]
        }
    }
}
