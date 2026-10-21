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
    
    @IBOutlet weak var ChangeBtnImg: UIButton!
    @IBOutlet weak var CountText: UILabel!
    var Images: [UIImage] = []
    var IconImg = ["DecoImg1","Monkey","Monkey","Monkey","Monkey","Monkey","Monkey","Monkey"]
    var Icon = ["DecoIcon1","Monkey","Monkey","Monkey","Monkey","Monkey","Monkey","Monkey"]
    var draggingImageView: MarkerBase?
    var correctMarkerCount = 0
    var SerectNumber = 0
    var SerectImg = ""
    var PictureCount = 0
    var DrawCount = 0
    var Changes = false
    var NowColor = UIColor(_colorLiteralRed: 252/255, green: 33/255, blue: 33/255, alpha: 1.0)
    
    @IBOutlet weak var EditView1: UIView!
    
    @IBOutlet weak var EditView2: UIView!
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        super.viewDidLoad()
        let newImage = UIImage(named: "ChangeBtn_2")
        
        self.ImgView.contentMode = .scaleAspectFill
        self.ImgView.clipsToBounds = true
        self.ImgView.image  = self.Images[self.DrawCount]
        self.ImgView.transform = CGAffineTransform(scaleX: -1, y: 1)
        self.CollectionView.delegate = self
        self.CollectionView.dataSource = self
        
        self.ChangeBtnImg.setImage(newImage, for: .normal)
        self.EditView1.isHidden = false
        self.EditView2.isHidden = true
        self.DrawingView.isUserInteractionEnabled = true
        self.CountText.text = "1/" +  String(self.SerectNumber)
        let color = UIColor(_colorLiteralRed: 252/255, green: 33/255, blue: 33/255, alpha: 1.0)
        
        self.DrawingView.lineColor = color
        self.HView.backgroundColor = color
        self.NowColor = color
        
        self.DrawingView.lineWidth = 10.0
        self.DrawingView.drawTool = ACEDrawingToolTypePen
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GoResult3" {
            
            if let Result = segue.destination as? ResultController {
                
                Result.Images = self.Images
                Result.PictureCount = self.PictureCount
                Result.SerectImg = self.SerectImg
                
            }
        }
        if segue.identifier == "GoResult2" {
            
            if let Result = segue.destination as? ResultController2 {
                
                Result.Images = self.Images
                Result.PictureCount = self.PictureCount
                Result.SerectImg = self.SerectImg
            }
        }
        if segue.identifier == "GoResult1" {
            
            if let Result = segue.destination as? ResultController3 {
                
                Result.Images = self.Images
                Result.PictureCount = self.PictureCount
                Result.SerectImg = self.SerectImg
            }
        }
    }
    
    @IBAction func RedBtn(_ sender: Any) {
        let color = UIColor(_colorLiteralRed: 252/255, green: 121/255, blue: 33/255, alpha: 1.0)

        self.DrawingView.lineColor = color
        self.HView.backgroundColor = color
        self.DrawingView.drawTool = ACEDrawingToolTypePen
        self.DrawingView.lineWidth = 10.0
        self.NowColor = color
    }
    
    @IBAction func OrangeBtn(_ sender: Any) {
        let color = UIColor(_colorLiteralRed: 252/255, green: 57/255, blue: 73/255, alpha: 1.0)

        self.DrawingView.lineColor = color
        self.HView.backgroundColor = color
        self.DrawingView.drawTool = ACEDrawingToolTypePen
        self.DrawingView.lineWidth = 10.0
        self.NowColor = color
    }
    
    @IBAction func YellowBtn(_ sender: Any) {
        let color = UIColor(_colorLiteralRed: 239/255, green: 32/255, blue: 117/255, alpha: 1.0)

        self.DrawingView.lineColor = color
        self.HView.backgroundColor = color
        self.DrawingView.drawTool = ACEDrawingToolTypePen
        self.DrawingView.lineWidth = 10.0
        self.NowColor = color
        
    }
    
    @IBAction func GrennBtn(_ sender: Any) {
        let color = UIColor(_colorLiteralRed: 253/255, green: 200/255, blue: 42/255, alpha: 1.0)

        self.DrawingView.lineColor = color
        self.HView.backgroundColor = color
        self.DrawingView.drawTool = ACEDrawingToolTypePen
        self.DrawingView.lineWidth = 10.0
        self.NowColor = color
        
    }
    
    @IBAction func BlueBtn(_ sender: Any) {
        let color = UIColor(_colorLiteralRed: 36/255, green: 189/255, blue: 184/255, alpha: 1.0)

        self.DrawingView.lineColor = color
        self.HView.backgroundColor = color
        self.DrawingView.drawTool = ACEDrawingToolTypePen
        self.DrawingView.lineWidth = 10.0
        self.NowColor = color
    }
    
    @IBAction func PinkBtn(_ sender: Any) {
        let color = UIColor(_colorLiteralRed: 162/255, green: 217/255, blue: 185/255, alpha: 1.0)

        self.DrawingView.lineColor = color
        self.HView.backgroundColor = color
        self.DrawingView.drawTool = ACEDrawingToolTypePen
        self.DrawingView.lineWidth = 10.0
        self.NowColor = color
    }
    
    @IBAction func BlackBtn(_ sender: Any) {
        let color = UIColor(_colorLiteralRed: 251/255, green: 218/255, blue: 173/255, alpha: 1.0)
        
        self.DrawingView.lineColor = color
        self.HView.backgroundColor = color
        self.DrawingView.drawTool = ACEDrawingToolTypePen
        self.DrawingView.lineWidth = 10.0
        self.NowColor = color
    }
    @IBAction func AlphaBtn(_ sender: Any) {
        let color = UIColor(_colorLiteralRed: 200/255, green: 196/255, blue: 188/255, alpha: 1.0)
        
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
        let decoName = self.IconImg[indexPath.row]
        let imgView = cell.viewWithTag(100) as? MarkerView
        
        print("cell")
        print(indexPath.row)
        print(imgName)
        print(imgView as Any)
        
        
        
        imgView?.delegate = self
        imgView?.image = UIImage(named: imgName)
        imgView?.markerName = decoName
        imgView?.isUserInteractionEnabled = true
        imgView?.alpha = 1.0
        
        
        return cell

    }

    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        return CGSize(width: 128, height: 128)
    }
    
    @IBAction func BackBtn(_ sender: Any) {
        self.Images[self.DrawCount] = SaveImage()
        

        if self.DrawCount + 1 >= self.SerectNumber {
            if self.SerectNumber == 1{
                
                self.performSegue(withIdentifier: "GoResult1",sender: nil)
                
            }else if self.SerectNumber == 4{
                
                self.performSegue(withIdentifier: "GoResult2",sender: nil)
                
            }else{
                self.performSegue(withIdentifier: "GoResult3",sender: nil)
            }
            
                
        } else {
            for subview in self.ResultView.subviews {
                if subview is MarkerBase {
                    subview.removeFromSuperview()
                }
            }
            
            self.DrawingView.clear()
                
            self.DrawCount += 1
            self.CountText.text = String(self.DrawCount + 1) + "/" +  String(self.SerectNumber)
            self.ImgView.image = self.Images[self.DrawCount]

            
        }
    }
    @IBAction func ChangeBtn(_ sender: Any) {
        
        if self.Changes{
            let newImage = UIImage(named: "ChangeBtn_2")
            self.ChangeBtnImg.setImage(newImage, for: .normal)
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
            let newImage = UIImage(named: "NextBtn")
            self.ChangeBtnImg.setImage(newImage, for: .normal)
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

        guard let decoImage = UIImage(named: markerCellImage.markerName) else {return}
        
        self.draggingImageView = MarkerBase.createMarker(image: decoImage)
        
        guard let draggingImageView = self.draggingImageView else {return}
        
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
