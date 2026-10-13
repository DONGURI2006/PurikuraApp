//
//  SerectController.swift
//  PurikuraApp
//
//  Created by 平井　登惟 on 2026/10/07.
//

import UIKit

class SerectController: UIViewController {
    
    var Player1Image: UIImage?
    var SerectNumber = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GoBackSerect" {
            
            if let Back = segue.destination as? BackSerectController {
                
                Back.SerectNumber = self.SerectNumber
                
            }
        }
    }
    @IBAction func Img1Btn(_ sender: Any) {
        self.SerectNumber = 1
        performSegue(withIdentifier: "GoBackSerect", sender: nil)
    }
    @IBAction func Img2Btn(_ sender: Any) {
        self.SerectNumber = 4
        performSegue(withIdentifier: "GoBackSerect", sender: nil)
    }
    @IBAction func Img3Btn(_ sender: Any) {
        self.SerectNumber = 6
        performSegue(withIdentifier: "GoBackSerect", sender: nil)
    }
}
