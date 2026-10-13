//
//  ImageView.swift
//  PurikuraApp
//
//  Created by 平井　登惟 on 2026/09/16.
//

import UIKit

class ImageView2: UICollectionViewCell {
    
    @IBOutlet weak var ImgView2: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.ImgView2.contentMode = .scaleAspectFill
        self.ImgView2.clipsToBounds = true
    }
}
