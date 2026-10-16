//
//  ViewController.swift
//  PurikuraApp
//
//  Created by 平井　登惟 on 2026/07/05.
//

import UIKit

class ViewController: UIViewController {
    
    var Player1Image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let TapAction = UITapGestureRecognizer(target: self,
                                               action: #selector(ScreenTapped))

        view.addGestureRecognizer(TapAction)
        
    }
    @objc func ScreenTapped() {
        self.performSegue(withIdentifier: "GoStart", sender: nil)
        
    }
}

