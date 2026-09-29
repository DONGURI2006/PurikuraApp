//
//  ImageView.swift
//  PurikuraApp
//
//  Created by 平井　登惟 on 2026/09/16.
//

import UIKit

class ImageView: UICollectionViewCell {
    
    @IBOutlet weak var ImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.ImgView.contentMode = .scaleAspectFill
        self.ImgView.clipsToBounds = true
    }
}
