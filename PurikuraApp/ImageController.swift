//
//  ImageController.swift
//  PurikuraApp
//
//  Created by 平井　登惟 on 2026/09/14.
//
import UIKit
import ACEDrawingView

class ImageController: UIViewController {
    
    @IBOutlet weak var HView: UIView!
    @IBOutlet weak var ResultView: UIView!
    @IBOutlet weak var DrawingView: ACEDrawingView!
    @IBOutlet weak var ImgView: UIImageView!
    var Images: [UIImage] = []
    var PictureCount = 0
    var DrawCount = 0
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        super.viewDidLoad()
        self.ImgView.contentMode = .scaleAspectFill
        self.ImgView.clipsToBounds = true
        self.ImgView.image  = self.Images[self.DrawCount]
        self.ImgView.transform = CGAffineTransform(scaleX: -1, y: 1)
        self.DrawingView.lineColor = UIColor(_colorLiteralRed: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        self.HView.backgroundColor = UIColor(_colorLiteralRed: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        
        self.DrawingView.lineWidth = 10.0
        self.DrawingView.drawTool = ACEDrawingToolTypePen
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GoDeco" {
            
            if let Result = segue.destination as? DecoController {
                
                Result.Images = self.Images
                Result.PictureCount = self.PictureCount
                
            }
        }
    }
    
    @IBAction func RedBtn(_ sender: Any) {
        let color = UIColor(_colorLiteralRed: 255/255, green: 38/255, blue: 0/255, alpha: 1.0)

        self.DrawingView.lineColor = color
        self.HView.backgroundColor = color
    }
    
    @IBAction func OrangeBtn(_ sender: Any) {
        let color = UIColor(_colorLiteralRed: 255/255, green: 147/255, blue: 0/255, alpha: 1.0)

        self.DrawingView.lineColor = color
        self.HView.backgroundColor = color
    }
    
    @IBAction func YellowBtn(_ sender: Any) {
        let color = UIColor(_colorLiteralRed: 255/255, green: 251/255, blue: 0/255, alpha: 1.0)

        self.DrawingView.lineColor = color
        self.HView.backgroundColor = color
        
    }
    
    @IBAction func GrennBtn(_ sender: Any) {
        let color = UIColor(_colorLiteralRed: 0/255, green: 249/255, blue: 0/255, alpha: 1.0)

        self.DrawingView.lineColor = color
        self.HView.backgroundColor = color
        
    }
    
    @IBAction func CyanBtn(_ sender: Any) {
        let color = UIColor(_colorLiteralRed: 0/255, green: 253/255, blue: 255/255, alpha: 1.0)

        self.DrawingView.lineColor = color
        self.HView.backgroundColor = color
    }
    
    @IBAction func BlueBtn(_ sender: Any) {
        let color = UIColor(_colorLiteralRed: 0/255, green: 51/255, blue: 255/255, alpha: 1.0)

        self.DrawingView.lineColor = color
        self.HView.backgroundColor = color
    }
    
    @IBAction func PinkBtn(_ sender: Any) {
        let color = UIColor(_colorLiteralRed: 255/255, green: 64/255, blue: 255/255, alpha: 1.0)

        self.DrawingView.lineColor = color
        self.HView.backgroundColor = color
    }
    
    @IBAction func BlackBtn(_ sender: Any) {
        let color = UIColor(_colorLiteralRed: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)

        self.DrawingView.lineColor = color
        self.HView.backgroundColor = color
    }
    
    func SaveImage() -> UIImage {

        let ViewRender = UIGraphicsImageRenderer(
            bounds: self.ResultView.bounds
        )

        let Img = ViewRender.image { context in
            self.ResultView.layer.render(in: context.cgContext)
        }

        return Img
    }
    
    @IBAction func BackBtn(_ sender: Any) {
        self.Images[self.DrawCount] = SaveImage()

        if self.DrawCount > 1 {
                
            self.performSegue(withIdentifier: "GoDeco",sender: nil)
                
        } else {
                
            self.DrawingView.clear()
                
            self.DrawCount += 1
                
            self.ImgView.image = self.Images[self.DrawCount]
        }
    }
}
