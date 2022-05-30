//
//  ViewController.swift
//  Concentration
//
//  Created by Tony Huang on 5/18/18.
//  Copyright © 2018 Tony Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var flipCount = 0 {
        didSet {
            flipCountLable.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLable: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices: Array<String> = ["🎃", "👻", "🎃", "👻"]
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            print ("cardNumber = \(cardNumber)")
        } else {
            print("chosen card was not in cardButtons")
        }
       
    }
    
    func flipCard (withEmoji emoji: String, on button: UIButton){
        //print ("flipCard (withEmoji: \(emoji))")
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
}

