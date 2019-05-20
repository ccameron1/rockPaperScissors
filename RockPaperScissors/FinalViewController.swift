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
    @IBOutlet weak var winOrLossLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let randomNum = CGFloat.random(in: 0...2)
        computerChoice = computerChoices[Int(randomNum)]
        print("computer Choice is \(computerChoice!)")
        
        print ("player choice is \(choiceString)")
        loadImages()
        
        determineWinOrLoss()
        
    }
    

    func loadImages() {
        
        playerImageView.image = UIImage(named: choiceString)
        computerImageView.image = UIImage(named: computerChoice!)
    }
    
    func determineWinOrLoss(){
        
//        var win = false
//        var tie = false
        
        if (computerChoice == choiceString){
            winOrLossLabel.text = "It's a tie!"
        } else if choiceString == "rock"{
            
            if computerChoice == "paper"{
                winOrLossLabel.text = "You lost. Better luck next time!"
            } else{
                winOrLossLabel.text = "You won!"
            }
            
        } else if choiceString == "paper"{
            if computerChoice == "scissors"{
                winOrLossLabel.text = "You lost. Better luck next time!"
            } else{
                winOrLossLabel.text = "You won!"
            }
        } else{
            if computerChoice == "rock"{
                winOrLossLabel.text = "You lost. Better luck next time!"
            } else {
                winOrLossLabel.text = "You won!"
            }
        }
        
    }

}
