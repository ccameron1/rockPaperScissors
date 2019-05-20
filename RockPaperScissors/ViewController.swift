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
    @IBOutlet weak var imageViewStack: UIStackView!
    @IBOutlet var imageViews: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        let fvc = segue.destination as! FinalViewController
     }
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        
        let selectedLabel = sender.location(in: imageViewStack)
        for image in imageViews {
            if image.frame.contains(selectedLabel) {
                choice = image
                
            }
        }
        print(choice)
        
    }
    
}

