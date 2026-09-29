//
//  ImageController.swift
//  PurikuraApp
//
//  Created by 平井　登惟 on 2026/09/14.
//
import UIKit
import Photos

class ResultController: UIViewController, UICollectionViewDelegate,
                        UICollectionViewDataSource,
                        UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var PurikuraFileView: UIView!
    var Images: [UIImage] = []
    var FinalImg : UIImage?
    var PictureCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        for i in 0...2{
            self.Images.append(self.Images[i])
        }
        
        self.CollectionView.delegate = self
        self.CollectionView.dataSource = self
        
        self.CollectionView.dragInteractionEnabled = false
        
        let longPress = UILongPressGestureRecognizer(target: self,action: #selector(longTap))
                
        self.CollectionView.addGestureRecognizer(longPress)
    }
    
    //セルの数をImages分作成
            
    func collectionView(_ collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int{
        return self.Images.count
    }
    
    //セルの中にある画像を順番ごとにimageの画像を入れる
            
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",for: indexPath) as! ImageView
                
        cell.self.ImgView.image = self.Images[indexPath.item]
                
        return cell
    }
    
    //セルのサイズと配置を3指定する
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        let width = (collectionView.bounds.width - 20) / 3
                
        return CGSize(width: width,height: width)
    }
    //もしもセルが動いたら住ん版を変更する
    func collectionView(_ collectionView: UICollectionView,moveItemAt sourceIndexPath: IndexPath,to destinationIndexPath: IndexPath) {
                
        let image = self.Images.remove(at: sourceIndexPath.item)
                
        self.Images.insert(image,at: destinationIndexPath.item)
    }
            
    //長押しした時に起こること
    @objc func longTap(_ gesture: UILongPressGestureRecognizer) {
                
        let location = gesture.location(in: CollectionView)
                
        switch gesture.state {
                    
            case .began:
                guard let indexPath = self.CollectionView.indexPathForItem(at: location) else {return}
                    
                self.CollectionView.beginInteractiveMovementForItem(at: indexPath)
                    
            case .changed:
                self.CollectionView.updateInteractiveMovementTargetPosition(location)
                    
            case .ended:
                self.CollectionView.endInteractiveMovement()
                    
                    
            default:
                self.CollectionView.cancelInteractiveMovement()
            }
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
