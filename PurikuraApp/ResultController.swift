//
//  ImageController.swift
//  PurikuraApp
//
//  Created by 平井　登惟 on 2026/09/14.
//
import UIKit

class ImageController: UIViewController {
    
    @IBOutlet weak var ImgView: UIImageView!
    var Images: [UIImage] = []
    var PictureCount = 0
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        super.viewDidLoad()
        self.ImgView.contentMode = .scaleAspectFill
        self.ImgView.clipsToBounds = true
        self.ImgView.image  = self.Images[PictureCount-1]
        self.ImgView.transform = CGAffineTransform(scaleX: -1, y: 1)
    }
    
    @IBAction func BackBtn(_ sender: Any) {
        if(PictureCount  < 6){
            if let navigationController = navigationController {

                for controller in navigationController.viewControllers {

                    if let CamerBack = controller as? CameraController {
                        CamerBack.Images = self.Images
                        CamerBack.PictureCount = self.PictureCount

                        self.navigationController?.popViewController(animated: true)
                        return
                    }
                }
            }
        }
        
    }
}
