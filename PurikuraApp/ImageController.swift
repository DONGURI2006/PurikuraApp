//
//  ImageController.swift
//  PurikuraApp
//
//  Created by 平井　登惟 on 2026/09/14.
//
import UIKit
import ACEDrawingView

class ImageController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var HView: UIView!
    @IBOutlet weak var ResultView: UIView!
    @IBOutlet weak var DrawingView: ACEDrawingView!
    @IBOutlet weak var ImgView: UIImageView!
    @IBOutlet weak var CollectionView: UICollectionView!
    
    var Images: [UIImage] = []
    var Icon = ["Monkey","Monkey","Monkey","Monkey","Monkey","Monkey","Monkey","Monkey"]
    var draggingImageView: MarkerBase?
    var correctMarkerCount = 0
    
    var PictureCount = 0
    var DrawCount = 0
    var Changes = false
    var NowColor = UIColor(_colorLiteralRed: 255/255, green: 38/255, blue: 0/255, alpha: 1.0)
    
    @IBOutlet weak var EditView1: UIView!
    
    @IBOutlet weak var EditView2: UIView!
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        super.viewDidLoad()
        self.ImgView.contentMode = .scaleAspectFill
        self.ImgView.clipsToBounds = true
        self.ImgView.image  = self.Images[self.DrawCount]
        self.ImgView.transform = CGAffineTransform(scaleX: -1, y: 1)
        self.CollectionView.delegate = self
        self.CollectionView.dataSource = self
        
        self.EditView1.isHidden = false
        self.EditView2.isHidden = true
        self.DrawingView.isUserInteractionEnabled = true
        
        let color = UIColor(_colorLiteralRed: 255/255, green: 38/255, blue: 0/255, alpha: 1.0)
        
        self.DrawingView.lineColor = color
        self.HView.backgroundColor = color
        self.NowColor = color
        
        self.DrawingView.lineWidth = 10.0
        self.DrawingView.drawTool = ACEDrawingToolTypePen
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GoResult" {
            
            if let Result = segue.destination as? ResultController {
                
                Result.Images = self.Images
                Result.PictureCount = self.PictureCount
                
            }
        }
    }
    
    @IBAction func RedBtn(_ sender: Any) {
        let color = UIColor(_colorLiteralRed: 255/255, green: 38/255, blue: 0/255, alpha: 1.0)

        self.DrawingView.lineColor = color
        self.HView.backgroundColor = color
        self.DrawingView.drawTool = ACEDrawingToolTypePen
        self.DrawingView.lineWidth = 10.0
        self.NowColor = color
    }
    
    @IBAction func OrangeBtn(_ sender: Any) {
        let color = UIColor(_colorLiteralRed: 255/255, green: 147/255, blue: 0/255, alpha: 1.0)

        self.DrawingView.lineColor = color
        self.HView.backgroundColor = color
        self.DrawingView.drawTool = ACEDrawingToolTypePen
        self.DrawingView.lineWidth = 10.0
        self.NowColor = color
    }
    
    @IBAction func YellowBtn(_ sender: Any) {
        let color = UIColor(_colorLiteralRed: 255/255, green: 251/255, blue: 0/255, alpha: 1.0)

        self.DrawingView.lineColor = color
        self.HView.backgroundColor = color
        self.DrawingView.drawTool = ACEDrawingToolTypePen
        self.DrawingView.lineWidth = 10.0
        self.NowColor = color
        
    }
    
    @IBAction func GrennBtn(_ sender: Any) {
        let color = UIColor(_colorLiteralRed: 0/255, green: 249/255, blue: 0/255, alpha: 1.0)

        self.DrawingView.lineColor = color
        self.HView.backgroundColor = color
        self.DrawingView.drawTool = ACEDrawingToolTypePen
        self.DrawingView.lineWidth = 10.0
        self.NowColor = color
        
    }
    
    @IBAction func BlueBtn(_ sender: Any) {
        let color = UIColor(_colorLiteralRed: 0/255, green: 51/255, blue: 255/255, alpha: 1.0)

        self.DrawingView.lineColor = color
        self.HView.backgroundColor = color
        self.DrawingView.drawTool = ACEDrawingToolTypePen
        self.DrawingView.lineWidth = 10.0
        self.NowColor = color
    }
    
    @IBAction func PinkBtn(_ sender: Any) {
        let color = UIColor(_colorLiteralRed: 255/255, green: 64/255, blue: 255/255, alpha: 1.0)

        self.DrawingView.lineColor = color
        self.HView.backgroundColor = color
        self.DrawingView.drawTool = ACEDrawingToolTypePen
        self.DrawingView.lineWidth = 10.0
        self.NowColor = color
    }
    
    @IBAction func BlackBtn(_ sender: Any) {
        let color = UIColor(_colorLiteralRed: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        
        self.DrawingView.lineColor = color
        self.HView.backgroundColor = color
        self.DrawingView.drawTool = ACEDrawingToolTypePen
        self.DrawingView.lineWidth = 10.0
        self.NowColor = color
    }
    @IBAction func AlphaBtn(_ sender: Any) {
        let color = UIColor(_colorLiteralRed: 155/255, green: 155/255, blue: 155/255, alpha: 1.0)
        
        self.DrawingView.lineColor = color
        self.HView.backgroundColor = color
        self.DrawingView.drawTool = ACEDrawingToolTypeEraser
        self.DrawingView.lineWidth = 30.0
        self.NowColor = color
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.Icon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = "cell"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,for: indexPath)
        
        cell.backgroundColor = .clear
        
        let imgName = self.Icon[indexPath.row]
        
        let imgView = cell.viewWithTag(100) as? MarkerView
        
        print("cell")
        print(indexPath.row)
        print(imgName)
        print(imgView as Any)
        
        
        
        imgView?.delegate = self
        imgView?.image = UIImage(named: imgName)
        imgView?.markerName = imgName
        imgView?.isUserInteractionEnabled = true
        imgView?.alpha = 1.0
        
        
        return cell

    }
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        return CGSize(width: 128, height: 128)
    }
    
    @IBAction func BackBtn(_ sender: Any) {
        self.Images[self.DrawCount] = SaveImage()
        

        if self.DrawCount > 1 {
                
            self.performSegue(withIdentifier: "GoResult",sender: nil)
                
        } else {
            for subview in self.ResultView.subviews {
                if subview is MarkerBase {
                    subview.removeFromSuperview()
                }
            }
            
            self.DrawingView.clear()
                
            self.DrawCount += 1
                
            self.ImgView.image = self.Images[self.DrawCount]
        }
    }
    @IBAction func ChangeBtn(_ sender: Any) {
        if self.Changes{

            self.EditView1.isHidden = false
            self.EditView2.isHidden = true
            self.DrawingView.lineColor = self.NowColor
            self.DrawingView.isUserInteractionEnabled = true
            for subview in self.ResultView.subviews {
                if let marker = subview as? MarkerBase {
                    marker.isUserInteractionEnabled = false
                }
            }
            self.Changes = false
        }else{
            
            self.EditView1.isHidden = true
            self.EditView2.isHidden = false
            self.DrawingView.isUserInteractionEnabled = false
            for subview in self.ResultView.subviews {
                if let marker = subview as? MarkerBase {
                    marker.isUserInteractionEnabled = true
                }
            }
            self.Changes = true
        }
        
    }
}

extension  ImageController : MarkerViewDelegate
{
    func MarkerViewDragStart(markerCellImage: MarkerView, location: CGPoint) {
        var markerImage: UIImage?
        
        guard let markerImage = markerCellImage.image else {return}
        
        self.draggingImageView = MarkerBase.createMarker(image: markerImage)
        self.draggingImageView?.frame = markerCellImage.convert(markerCellImage.bounds, to: self.ResultView)
        
        self.draggingImageView?.delegate = self
        
        self.draggingImageView?.alpha = 0.5
        
        self.ResultView.addSubview(self.draggingImageView!)
                
        
        
        
    }
    
    func MarkerViewChange(markerCellImage: MarkerView, location: CGPoint) {
        guard let draggingImageView = self.draggingImageView else { return }
        draggingImageView.center = location
    }
    
    func MarkerViewStop(markerCellImage: MarkerView, location: CGPoint) {
        guard let draggingImageView = self.draggingImageView else { return  }
        
        
        UIView.animate(withDuration: 0.2) {
            draggingImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            draggingImageView.alpha = 1.0
        }
        
        self.draggingImageView = nil
    }
}

extension ImageController : MarkerDelegate
{
    func didMoveMarker()
    {
        self.correctMarkerCount += 1
    }
}
