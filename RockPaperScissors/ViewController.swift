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
    @IBOutlet weak var timerButton: UIButton!
    
//    let timeArray = ["3","2","1","0"]
    var counter = 0
    
    var time = 3
    
    var timer : Timer?
    
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
        
        timer?.invalidate()
        performSegue(withIdentifier: "viewToFinalSegue", sender: nil)
        
    }
    
    @IBAction func onRulesPressed(_ sender: UIButton) {
        UIApplication.shared.openURL(NSURL(string: "http://www.wrpsa.com/the-official-rules-of-rock-paper-scissors/") as! URL)
    }
    
    @IBAction func timerStartButtonPressed(_ sender: UIButton) {
    
        self.timerButton.isEnabled = false
        
        var runCount = 4
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            runCount -= 1
            self.changeTimerLabel(string: "\(runCount)")
            if runCount == 0 {
                timer.invalidate()
                let alertController = UIAlertController(title: "YOU LOSE", message: "Please select an image before the timer runs out.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                    runCount = 3
                    self.timerLabel.text = "3"
                    self.timerButton.isEnabled = true
                })
                alertController.addAction(alertAction)
                self.present(alertController, animated: true)
            }
        }
        
    }
    
    @objc func changeTimerLabel(string : String) {
        timerLabel.text = String(string)
    }
}

