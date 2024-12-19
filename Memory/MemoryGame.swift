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
        guard !buttons[index].isBtnSameColor else { return }
        guard !buttons[index].isFlipped else { return }
        
        buttons[index].isBtnWhite.toggle()
    }
    
    init(NumOfBtnPairs: Int) {
        for BtnID in 0..<NumOfBtnPairs {
            let btn = Btn(BtnID: BtnID)
            buttons += [btn, btn]
        }
        buttons.shuffle()
    }
}
