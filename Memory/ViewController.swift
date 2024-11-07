//
//  ViewController.swift
//  Memory
//
//  Created by Sven Büttner on 2024/10/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var BtnList: [UIButton]!
    
    @IBOutlet weak var pairCounter: UILabel!
    
    private var memoryGame = MemoryGame()
    
    var isFlipped = false
    var currColour: UIColor = UIColor.systemGray5
    var prevColour: UIColor = UIColor.systemGray5
    //    var pairCount: Int = 0 {
    //        didSet { pairCounter.text = "\(pairCount)" }
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        //        let shuffledColours = colours.shuffled()
        //
        //        for (index, button) in BtnList.enumerated() {
        //            button.tintColor = shuffledColours[index]
        //        }
    }
    
    func updateUI() {
        for (index, button) in BtnList.enumerated() {
            button.tintColor = memoryGame.colours[index]
            button.isEnabled = true
        }
        pairCounter.text = "\(memoryGame.pairCount)"
    }
    
    @IBAction func btnTapped(_ sender: UIButton) {
        let btnIndex = BtnList.firstIndex(of: sender)!
        
        if memoryGame.flippedButtons.count < 2 {
            sender.tintColor = memoryGame.colours[btnIndex]
            memoryGame.flippedButtons.append(btnIndex)
        }
        
        if memoryGame.flippedButtons.count == 2 {
            let firstIndex = memoryGame.flippedButtons[0]
            let secondIndex = memoryGame.flippedButtons[1]
            
            if memoryGame.isMatch(index1: firstIndex, index2: secondIndex) {
                memoryGame.increasePairCount()
                pairCounter.text = "\(memoryGame.pairCount)"
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.BtnList[firstIndex].tintColor = UIColor.systemGray5
                    self.BtnList[secondIndex].tintColor = UIColor.systemGray5
                }
            }
            memoryGame.flippedButtons.removeAll()
        }
    }
}
    
//    @IBAction func reset(_ sender: UIButton) {
//        for btn in BtnList {
//            btn.backgroundColor = UIColor.systemGray5
//        }
//            isFlipped = false
//            flippedBtns.removeAll()
//            currColour = UIColor.systemGray5
//            prevColour = UIColor.systemGray5
//            pairCount = 0
//    }
//    
//    
//    func ClickBtn(sign signin: String, on button: UIButton) {
//        let btnIndex = BtnList.firstIndex(of: button)!
//        
//
//        if button.backgroundColor == UIColor.systemGray5 {
//            button.backgroundColor = button.tintColor
//            if !isFlipped {
//                isFlipped = true
//                prevColour = button.tintColor
//            } else if isFlipped {
//                currColour = button.tintColor
//                if prevColour == currColour {
//                    pairCount += 1
//                } else {
//                    for btn in flippedBtns {
//                        BtnList[btn].backgroundColor = UIColor.systemGray5
//                    }
//                }
//                isFlipped = false
//                flippedBtns.removeAll()
//            }
//        }
//    }
//    
//}

