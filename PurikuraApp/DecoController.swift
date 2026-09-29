//
//  DecoController.swift
//  PurikuraApp
//
//  Created by 平井　登惟 on 2026/09/25.
//

import UIKit

class DecoController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    @IBOutlet weak var ResultView: UIView!
    @IBOutlet weak var GoImage: UIImageView!
    @IBOutlet weak var CollectionView: UICollectionView!
    
    
    var Images: [UIImage] = []
    var Icon = ["Monkey","Monkey","Monkey"]
    var draggingImageView: MarkerBase?
    var PictureCount = 0
    var DrawCount = 0
    var correctMarkerCount = 0
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        super.viewDidLoad()
        
        self.GoImage.contentMode = .scaleAspectFill
        self.GoImage.clipsToBounds = true
        self.GoImage.image  = self.Images[self.DrawCount]
        
        self.CollectionView.delegate = self
        self.CollectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GoResult" {
            
            if let Result = segue.destination as? ResultController {
                
                Result.Images = self.Images
                Result.PictureCount = self.PictureCount
                
            }
        }
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
        
        for subview in self.ResultView.subviews {
            if subview is MarkerBase {
                subview.removeFromSuperview()
            }
        }
        
        if self.DrawCount > 1 {
                
            self.performSegue(withIdentifier: "GoResult",sender: nil)
                
        } else {
                
                
            self.DrawCount += 1
                
            self.GoImage.image = self.Images[self.DrawCount]
        }
    }
    
}


extension  DecoController : MarkerViewDelegate
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

extension DecoController : MarkerDelegate
{
    func didMoveMarker()
    {
        self.correctMarkerCount += 1
    }
}
