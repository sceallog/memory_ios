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
    
    let emojis = [
        "🚌", "🚌", "🚗", "🚗", "✈️", "✈️", "🚁", "🚁", "🚄", "🚄", "🚃", "🚃"
    ]
    
    var flippedBtns: [Int] = []
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
            
            let firstEmoji = BtnList[firstBtnIndex].currentTitle ?? ""
            let secondEmoji = BtnList[secondBtnIndex].currentTitle ?? ""

            if firstEmoji == secondEmoji {
                pairCount += 1
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.game.buttons[firstBtnIndex].toggleFlip()
                    self.game.buttons[secondBtnIndex].toggleFlip()
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
        }
        flippedBtns.removeAll()
        pairCount = 0
        shuffleBtnColours()
        updateViewFromModel()
            
    }
   
    func shuffleBtnColours() {
        let shuffledEmojis = emojis.shuffled()

        for (index, button) in BtnList.enumerated() {
            button.setTitle(shuffledEmojis[index], for: .normal)
            button.setTitleColor(.clear, for: .normal)
            button.setTitleColor(.black, for: .disabled)
        }
    }
    
   func updateViewFromModel() {
        for index in BtnList.indices {
            let button = BtnList[index]
            let btn = game.buttons[index]
            
            btn.isFlipped ? (button.isEnabled = false) : (button.isEnabled = true)
       }
    }
    
}

