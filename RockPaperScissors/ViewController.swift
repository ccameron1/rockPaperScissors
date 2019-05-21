//
//  ViewController.swift
//  RockPaperScissors
//
//  Created by Carly Cameron on 5/20/19.
//  Copyright © 2019 Carly Cameron. All rights reserved.
//

import UIKit


class ViewController: UIViewController, ImagePickerDelegate {
    
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
    }
    
    //following function handle double taps and active an image selector
    @IBAction func doubleTap(_ sender: UIGestureRecognizer) {
        print("double")
        selectedImageView = rockImageView
        //add image code here
        showImagePicker(rockImageView)
    }
    
    @IBAction func doubleTap2(_ sender: UIGestureRecognizer) {
        print("double")
        selectedImageView = paperImageView
        //add image code here
        showImagePicker(paperImageView)
    }
    
    @IBAction func doubleTap3(_ sender: UIGestureRecognizer) {
        print("double")
        selectedImageView = scissorsImageView
        //add image code here
        showImagePicker(scissorsImageView)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let fvc = segue.destination as! FinalViewController
        fvc.choiceString = choiceString
        fvc.paperImage = paperImage
        fvc.rockImage = rockImage
        fvc.scissorImage = scissorImage
        
        timerLabel.text = "3"
        timerButton.isEnabled = true
        hasTimeBeenPressed = false
        
    }
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        
        //makes sure the the timer has been pressed before the user can play
        if hasTimeBeenPressed == true{
            
            //reads where the user clicked
            let selectedLabel = sender.location(in: imageViewStack)
            for image in imageViews {
                if image.frame.contains(selectedLabel) {
                    choice = image
                    
                }
            }
            
            //decides what has been selected
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
            
        } else {
            print ("Timer hasn't been pressed yet")
        }
        
        
        
        
    }
    
    @IBAction func onRulesPressed(_ sender: UIButton) {
        //goes to the OFFICIAL RPS rules
        UIApplication.shared.openURL(NSURL(string: "http://www.wrpsa.com/the-official-rules-of-rock-paper-scissors/")! as URL)
    }
    
    @IBAction func timerStartButtonPressed(_ sender: UIButton) {
        
        hasTimeBeenPressed = true
        
        //sets up the time to run for three seconds/
        var runCount = 4
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            //self.imageViewStack.isUserInteractionEnabled = true
            self.timerButton.isEnabled = false
            runCount -= 1
            self.changeTimerLabel(string: "\(runCount)")
            if runCount == 0 {
                timer.invalidate()
                
                //alert controller when the time runs out and no selection has happened
                let alertController = UIAlertController(title: "YOU LOSE", message: "Please select an image before the timer runs out.", preferredStyle: .alert)
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
        
    }
    
    //changes timer as it counts down
    @objc func changeTimerLabel(string : String) {
        timerLabel.text = String(string)
    }
    
    @IBAction func unwindToStart(segue: UIStoryboardSegue){
        
    }
    
}



