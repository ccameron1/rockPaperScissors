//
//  ViewController.swift
//  RockPaperScissors
//
//  Created by Carly Cameron on 5/20/19.
//  Copyright © 2019 Carly Cameron. All rights reserved.
//

import UIKit
import SafariServices


class ViewController: UIViewController, ImagePickerDelegate, SFSafariViewControllerDelegate {
    
    //function reads the image the user picker and switch statement decides where it goes.
    var selectedImageView : UIImageView?
    func didSelect(image: UIImage?) {
        switch selectedImageView{
        case rockImageView:
            rockImage = image
            self.rockImageView.image = rockImage
        case paperImageView:
            paperImage = image
            self.paperImageView.image = paperImage
        case scissorsImageView:
            scissorImage = image
            self.scissorsImageView.image = scissorImage
        default:
            break
        }
    }
    
    
    var imagePicker: ImagePicker!
    var imagePickerController : UIImagePickerController!
    
    var rockImage = UIImage(named: "rock")
    var paperImage = UIImage(named: "paper")
    var scissorImage = UIImage(named: "scissors")

    var didChoose = false
    var choice : UIImageView?
    var choiceString = ""
    @IBOutlet weak var imageViewStack: UIStackView!
    @IBOutlet var imageViews: [UIImageView]!
    @IBOutlet weak var rockImageView: UIImageView!
    @IBOutlet weak var paperImageView: UIImageView!
    @IBOutlet weak var scissorsImageView: UIImageView!
    @IBOutlet weak var spStackView: UIStackView!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    
    var counter = 0
    var time = 3
    var timer : Timer?
    var hasTimeBeenPressed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGestureRecognizer()
        //intializes image picker
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
    }
    
    //function that will create and show image picker to user library
    @IBAction func showImagePicker(_ sender: UIImageView) {
        self.imagePicker.present(from: sender)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    //sets up double taps for each image view
    func setUpGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTap(_:)))
        tap.numberOfTapsRequired = 2
        rockImageView.addGestureRecognizer(tap)
        rockImageView.isUserInteractionEnabled = true
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(doubleTap2(_:)))
        tap2.numberOfTapsRequired = 2
        paperImageView.addGestureRecognizer(tap2)
        paperImageView.isUserInteractionEnabled = true
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(doubleTap3(_:)))
        tap3.numberOfTapsRequired = 2
        scissorsImageView.addGestureRecognizer(tap3)
        scissorsImageView.isUserInteractionEnabled = true
        
        //sets up the 3 images to allow tapgestures
        let tapAll = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapAll.numberOfTapsRequired = 1
        imageViewStack.addGestureRecognizer(tapAll)
        imageViewStack.isUserInteractionEnabled = true
        
    }
    
    //following 3 functions handle double taps and active an image selector
    @IBAction func doubleTap(_ sender: UIGestureRecognizer) {
        selectedImageView = rockImageView
        showImagePicker(rockImageView)
    }
    
    @IBAction func doubleTap2(_ sender: UIGestureRecognizer) {
        selectedImageView = paperImageView
        showImagePicker(paperImageView)
    }
    
    @IBAction func doubleTap3(_ sender: UIGestureRecognizer) {
        selectedImageView = scissorsImageView
        showImagePicker(scissorsImageView)
    }

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let fvc = segue.destination as! FinalViewController
        fvc.choiceString = choiceString
        fvc.paperImage = paperImage
        fvc.rockImage = rockImage
        fvc.scissorImage = scissorImage
        
        //reset the timer button and label
        timerLabel.text = "3"
        timerButton.isEnabled = true
        hasTimeBeenPressed = false
        
    }
    
    //this function is for the rock paper and scissors images
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        
        //makes sure the the timer has been pressed before the user can play
        if hasTimeBeenPressed == true {
            
            //reads where the user clicked within the stackview
            let selectedLabel = sender.location(in: imageViewStack)
            
            if rockImageView.frame.contains(selectedLabel)
            {
                choice = rockImageView
            }
            if spStackView.frame.contains(selectedLabel)
            {
                let selectedTemp = sender.location(in: spStackView)
                
                if paperImageView.frame.contains(selectedTemp)
                {
                    choice = paperImageView
                }
                else
                {
                    choice = scissorsImageView
                }
            }
            
            //decides what has been selected
            switch choice {
            case rockImageView:
                choiceString = ("rock")
            case paperImageView:
                choiceString = ("paper")
            case scissorsImageView:
                choiceString = ("scissors")
            default:
                break
            }
            
            //go to the results page
            timer?.invalidate()
            performSegue(withIdentifier: "viewToFinalSegue", sender: nil)
            
        } else {
            //alert controller when the user has not started the timer yet but tries to select an image
            let alertController = UIAlertController(title: "Try Again", message: "Please start the timer before selecting.", preferredStyle: .alert)
            //create the actions that the alert controller will do
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                //this is where you add any extra actions
                print ("Timer hasn't been pressed yet")
            })
            alertController.addAction(alertAction)
            //actually shows the alert controller
            self.present(alertController, animated: true)

        }
        
    }
    
    
    @IBAction func onRulesButtonPressed(_ sender: Any) {
        
        let link = URL(string: "http://www.wrpsa.com/the-official-rules-of-rock-paper-scissors/")
        let sfvc = SFSafariViewController(url: link!)
        sfvc.delegate = (self as! SFSafariViewControllerDelegate)
        
        present(sfvc, animated: true)
        
    }
    
    
    @IBAction func timerStartButtonPressed(_ sender: UIButton) {
        
        hasTimeBeenPressed = true
        
        //sets up the time to run for three seconds/
        var runCount = 3
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            //self.imageViewStack.isUserInteractionEnabled = true
            self.timerButton.isEnabled = false
            runCount -= 1
            self.changeTimerLabel(string: "\(runCount)")
            if runCount == 0 && !self.didChoose{
                timer.invalidate()
                
                //alert controller when the time runs out and no selection has happened
                let alertController = UIAlertController(title: "Try Again", message: "Please select an image before the timer runs out.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                    runCount = 3
                    self.timerLabel.text = "3"
                    self.timerButton.isEnabled = true
                    //self.imageViewStack.isUserInteractionEnabled = false
                })
                alertController.addAction(alertAction)
                self.present(alertController, animated: true)
            }
            
            
        }
        if runCount <= 0 {
            timer?.invalidate()
        }
        self.didChoose = false
        
    }
    
    //changes timer as it counts down
    @objc func changeTimerLabel(string : String) {
        timerLabel.text = String(string)
    }
    
    @IBAction func unwindToStart(segue: UIStoryboardSegue){
        
    }
    
}



