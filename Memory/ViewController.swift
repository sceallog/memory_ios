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
        
        let shuffledColours = colours.shuffled()

        for (index, button) in BtnList.enumerated() {
            button.tintColor = shuffledColours[index]
        }
    }
    
    @IBAction func clickBtn(_ sender: UIButton) {
        ClickCounter += 1
        if let btnNumber = BtnList.firstIndex(of: sender) {
            game.chooseBtn(at: btnNumber)
            updateViewFromModel()
        } else {
            print("Error: Button not found")
        }
    }
    
    @IBAction func reset(_ sender: UIButton) {
        for btn in BtnList {
            btn.backgroundColor = UIColor.systemGray5
        }
            isFlipped = false
            flippedBtns.removeAll()
            currColour = UIColor.systemGray5
            prevColour = UIColor.systemGray5
            pairCount = 0
    }
    
   func updateViewFromModel() {
        for index in BtnList.indices {
            let button = BtnList[index]
            let btn = game.buttons[index]
            if !btn.isBtnWhite {
                print("Not white")
            } else {
                print("White")
            }
       }
    }
    
}

