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
    
    @IBAction func btn(_ sender: UIButton) {
        ClickBtn(sign: "r", on: sender)
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
    
    
    func ClickBtn(sign signin: String, on button: UIButton) {
        let btnIndex = BtnList.firstIndex(of: button)!
        flippedBtns.append(btnIndex)

        if button.backgroundColor == UIColor.systemGray5 {
            button.backgroundColor = button.tintColor
            if !isFlipped {
                isFlipped = true
                prevColour = button.tintColor
            } else if isFlipped {
                currColour = button.tintColor
                if prevColour == currColour {
                    pairCount += 1
                } else {
                    for btn in flippedBtns {
                        BtnList[btn].backgroundColor = UIColor.systemGray5
                    }
                }
                isFlipped = false
                flippedBtns.removeAll()
            }
        }
    }
    
}

