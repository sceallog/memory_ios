//
//  MemoryGame.swift
//  Memory
//
//  Created by Sven Büttner on 2024/11/07.
//

import UIKit

class MemoryGame {
    private(set) var colours: [UIColor] = [.red, .red, .blue, .blue, .green, .green, .yellow, .yellow, .purple, .purple, .orange, .orange]
    var flippedButtons: [Int] = []
    private(set) var pairCount: Int = 0
    
    init() {
        shuffleColours()
    }
    
    func shuffleColours() {
        colours.shuffle()
    }
    
    func isMatch(index1: Int, index2: Int) -> Bool {
        return colours[index1] == colours[index2]
    }
    
    func increasePairCount() {
        pairCount += 1
    }
    
    func resetGame() {
        pairCount = 0
        flippedButtons.removeAll()
        shuffleColours()
    }
}
