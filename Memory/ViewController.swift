//
//  ViewController.swift
//  Memory
//
//  Created by Sven Büttner on 2024/10/24.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = MemoryGame(NumOfBtnPairs: BtnList.count / 2)
    
    var ClickCounter = 0 {
        didSet {
            pairCounter.text = "\(ClickCounter)"
        }
    }
    @IBOutlet var BtnList: [UIButton]!
    
    @IBOutlet weak var pairCounter: UILabel!
    
    let colours: [UIColor] = [
        .red, .red, .blue, .blue, .green, .green, .yellow, .yellow, .purple, .purple, .orange, .orange
    ]
    
    var isFlipped = false
    var flippedBtns: [Int] = []
    var currColour: UIColor = UIColor.systemGray5
    var prevColour: UIColor = UIColor.systemGray5
    var pairCount: Int = 0 {
        didSet { pairCounter.text = "\(pairCount)" }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shuffleBtnColours()
        
    }
    
    @IBAction func clickBtn(_ sender: UIButton) {
        guard let btnIndex = BtnList.firstIndex(of: sender) else {
            print("Error: Button not found")
            return
        }
        
        if game.buttons[btnIndex].isFlipped || flippedBtns.contains(btnIndex) { return }
        
        flippedBtns.append(btnIndex)
        game.chooseBtn(at: btnIndex)
        
        if flippedBtns.count == 2 {
            let firstBtnIndex = flippedBtns[0]
            let secondBtnIndex = flippedBtns[1]
            
            let firstColor = BtnList[firstBtnIndex].tintColor
            let secondColor = BtnList[secondBtnIndex].tintColor
            
            if firstColor == secondColor {
                pairCount += 1
                game.buttons[firstBtnIndex].isFlipped = true
                game.buttons[secondBtnIndex].isFlipped = true
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.game.buttons[firstBtnIndex].isBtnWhite = true
                    self.game.buttons[secondBtnIndex].isBtnWhite = true
                    self.updateViewFromModel()
                }
            }
            flippedBtns.removeAll()
        }
        
        updateViewFromModel()
        
    }
    
    @IBAction func reset(_ sender: UIButton) {
        for (index, btn) in BtnList.enumerated() {
            btn.backgroundColor = UIColor.systemGray5
            btn.isUserInteractionEnabled = true
            game.buttons[index].isFlipped = false
            game.buttons[index].isBtnWhite = true
        }
        isFlipped = false
        flippedBtns.removeAll()
        pairCount = 0
        shuffleBtnColours()
        updateViewFromModel()
            
    }
   
    func shuffleBtnColours() {
        let shuffledColours = colours.shuffled()

        for (index, button) in BtnList.enumerated() {
            button.tintColor = shuffledColours[index]
        }
    }
    
   func updateViewFromModel() {
        for index in BtnList.indices {
            let button = BtnList[index]
            let btn = game.buttons[index]
            
            if btn.isFlipped {
                button.backgroundColor = button.tintColor
                button.isUserInteractionEnabled = false
            } else if btn.isBtnWhite {
                button.backgroundColor = UIColor.systemGray5
            } else {
                button.backgroundColor = button.tintColor
            }
       }
    }
    
}

