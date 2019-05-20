//
//  FinalViewController.swift
//  RockPaperScissors
//
//  Created by Carly Cameron on 5/20/19.
//  Copyright © 2019 Carly Cameron. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {

    var choiceString = ""
    var computerChoices = ["Rock", "Paper", "Scissors"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let randomNum = CGFloat.random(in: 0...2)
        let computerChoice = computerChoices[Int(randomNum)]
        print("computer Choice is \(computerChoice)")
        
        print ("player choice is \(choiceString)")
    }
    

    

}
