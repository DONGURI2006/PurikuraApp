//
//  BackSerectController.swift
//  PurikuraApp
//
//  Created by 平井　登惟 on 2026/10/07.
//


import UIKit

class BackSerectController: UIViewController,UICollectionViewDelegate,
                            UICollectionViewDataSource,
                            UICollectionViewDelegateFlowLayout {
    
    var SerectNumber = 0;
    var SerectImg = ""
    let BackImages = ["Monkey","Monkey","Monkey","Monkey","Monkey","Monkey"]
    var TimeCount = 10
    var CountTimer: Timer?
    @IBOutlet weak var CountText: UILabel!
    @IBOutlet weak var SerectImgView1: UIView!
    @IBOutlet weak var SerectImgView2: UIView!
    @IBOutlet weak var SerectImgView3: UIView!
    @IBOutlet weak var ImgView: UIImageView!
    @IBOutlet weak var BackGarundControllerView: UICollectionView!
    @IBOutlet weak var BackImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.CountText.text = "10"
        self.SerectImgView1.isHidden = true
        self.SerectImgView2.isHidden = true
        self.SerectImgView3.isHidden = true
        
        if self.SerectNumber == 1{
            self.SerectImgView1.isHidden = false

        }else if self.SerectNumber == 4{

            self.SerectImgView2.isHidden = false

        }else{
            self.SerectImgView3.isHidden = false
        }
        
        self.BackGarundControllerView.delegate = self
        self.BackGarundControllerView.dataSource = self
        
        self.CountTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            
            self.TimeCount -= 1
            self.CountText.text = String(self.TimeCount)
            if self.TimeCount < 0{
                self.CountTimer?.invalidate()
                self.CountTimer = nil
                self.CountText.text = "0"
                self.performSegue(withIdentifier: "GoCamera", sender: nil)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int {
        return self.BackImages.count
    }
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = "BackCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,for: indexPath)
        
        cell.backgroundColor = .clear
        
        if let imageView = cell.viewWithTag(1) as? UIImageView {
            let imgName = self.BackImages[indexPath.item]
            
            imageView.image = UIImage(named: imgName)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
        }
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {

        let layout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpacing =
            layout.sectionInset.left +
            layout.sectionInset.right +
            layout.minimumInteritemSpacing * 2

        let width = (collectionView.bounds.width - totalSpacing) / 3

        return CGSize(width: width * 0.8, height: width * 0.5)
    }

    func collectionView(_ collectionView: UICollectionView,didSelectItemAt indexPath: IndexPath) {
        
        self.SerectImg = self.BackImages[indexPath.item]
        BackImg.image = UIImage(named: self.BackImages[indexPath.item])
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GoCamera" {
            
            if let Camera = segue.destination as? CameraController {
                
                Camera.SerectNumber = self.SerectNumber
                Camera.SerectImg = self.SerectImg
                
            }
        }
    }
}
