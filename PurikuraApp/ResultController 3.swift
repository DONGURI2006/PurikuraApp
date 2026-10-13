//  ImageController.swift
//  PurikuraApp
//
//  Created by 平井　登惟 on 2026/09/14.
//
import UIKit
import Photos

class ResultController3: UIViewController {


    @IBOutlet weak var PurikuraFileView: UIView!
    @IBOutlet weak var BackgroundImg: UIImageView!
    @IBOutlet weak var ImgView: UIImageView!
    
    var Images: [UIImage] = []
    var FinalImg : UIImage?
    var PictureCount = 0
    var SerectImg = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        self.BackgroundImg.image = UIImage(named: SerectImg)
        self.ImgView.image = Images[0]
    }

    
    func SaveImage() -> UIImage {
        let ViewRender = UIGraphicsImageRenderer(
            bounds: self.PurikuraFileView.bounds
        )
        let Img = ViewRender.image { context in
            self.PurikuraFileView.layer.render(in: context.cgContext)
        }
        return Img
    }
    
    
    @IBAction func SaveBtn(_ sender: Any) {
        
        self.FinalImg  = SaveImage()
        
        guard let image = self.FinalImg
        else {
            return
        }
            PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
            guard status == .authorized || status == .limited else {
                return
            }

            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAsset(from: image)
            }) { success, error in
                DispatchQueue.main.async {
                    if success {
                        print("保存成功")
                    } else {
                        print(error?.localizedDescription ?? "保存失敗")
                    }
                }
            }
        }
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
