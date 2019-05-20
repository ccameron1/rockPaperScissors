//
//  ViewController.swift
//  RockPaperScissors
//
//  Created by Carly Cameron on 5/20/19.
//  Copyright © 2019 Carly Cameron. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        //ignore
    }

    
     var imagePicker: ImagePicker!
    

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
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
    }
    
    @IBAction func showImagePicker(_ sender: UIImageView) {
        self.imagePicker.present(from: sender)
    }

    
    override func viewDidAppear(_ animated: Bool) {
        //imageViewStack.isUserInteractionEnabled = false
    }
    
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
    
    @IBAction func doubleTap(_ sender: UIGestureRecognizer) {
        print("double")
        //add image code here
        showImagePicker(rockImageView)
        //need to set image
        
    }
    
    @IBAction func doubleTap2(_ sender: UIGestureRecognizer) {
        print("double")
        //add image code here
        showImagePicker(paperImageView)
        //need to set image
    }
    
    @IBAction func doubleTap3(_ sender: UIGestureRecognizer) {
        print("double")
        //add image code here
        showImagePicker(scissorsImageView)
        //need to set image
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
        
        if hasTimeBeenPressed == true{
            
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
            
        } else {
            print ("Timer hasn't been pressed yet")
        }
        
        
        
        
    }
    
    @IBAction func onRulesPressed(_ sender: UIButton) {
        UIApplication.shared.openURL(NSURL(string: "http://www.wrpsa.com/the-official-rules-of-rock-paper-scissors/")! as URL)
    }
    
    @IBAction func timerStartButtonPressed(_ sender: UIButton) {
    
        hasTimeBeenPressed = true
        
        var runCount = 4
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            //self.imageViewStack.isUserInteractionEnabled = true
            self.timerButton.isEnabled = false
            runCount -= 1
            self.changeTimerLabel(string: "\(runCount)")
            if runCount == 0 {
                timer.invalidate()
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
    
    @objc func changeTimerLabel(string : String) {
        timerLabel.text = String(string)
    }
    
    //who knows
    func setUpImagePicker() {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        pickerController.allowsEditing = true
        pickerController.mediaTypes = ["public.image", "public.movie"]
        pickerController.sourceType = .photoLibrary
        
    }
    
    
}

