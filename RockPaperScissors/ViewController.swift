//
//  ViewController.swift
//  RockPaperScissors
//
//  Created by Carly Cameron on 5/20/19.
//  Copyright © 2019 Carly Cameron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var choice : UIImageView?
    var choiceString = ""
    @IBOutlet weak var imageViewStack: UIStackView!
    @IBOutlet var imageViews: [UIImageView]!
    @IBOutlet weak var rockImageView: UIImageView!
    @IBOutlet weak var paperImageView: UIImageView!
    @IBOutlet weak var scissorsImageView: UIImageView!
    @IBOutlet weak var webButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    
    var time = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        let fvc = segue.destination as! FinalViewController
        fvc.choiceString = choiceString
     }
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        
        let selectedLabel = sender.location(in: imageViewStack)
        for image in imageViews {
            if image.frame.contains(selectedLabel) {
                choice = image
                
            }
        }
        
        switch choice{
        case rockImageView:
            choiceString = ("rock")
        case paperImageView:
            choiceString = ("paper")
        case scissorsImageView:
            choiceString = ("scissors")
        default:
            break
        }
        
        performSegue(withIdentifier: "viewToFinalSegue", sender: nil)
        
    }
    
    @IBAction func onRulesPressed(_ sender: UIButton) {
        UIApplication.shared.openURL(NSURL(string: "http://www.wrpsa.com/the-official-rules-of-rock-paper-scissors/") as! URL)
    }
    
    @IBAction func timerStartButtonPressed(_ sender: UIButton) {
        
        let timeOne = Date().addingTimeInterval(1)
        let timer = Timer(fireAt: timeOne, interval: 0, target: self, selector: #selector(changeTimerLabel), userInfo: nil, repeats: false)
        RunLoop.main.add(timer, forMode: .common)
    }
    
    @objc func changeTimerLabel() {
        timerLabel.text = String(time)
    }
}

