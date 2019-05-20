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
    var computerChoices = ["rock", "paper", "scissors"]
    var computerChoice : String?
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var computerImageView: UIImageView!
    @IBOutlet weak var WinOrLossLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let randomNum = CGFloat.random(in: 0...2)
        computerChoice = computerChoices[Int(randomNum)]
        print("computer Choice is \(computerChoice)")
        
        print ("player choice is \(choiceString)")
        loadImages()
    }
    

    func loadImages() {
        
        playerImageView.image = UIImage(named: choiceString)
        computerImageView.image = UIImage(named: computerChoice!)
    }
    

}
