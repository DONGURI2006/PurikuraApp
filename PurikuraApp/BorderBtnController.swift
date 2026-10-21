//
//  BorderBtnController.swift
//  GakuryokuB
//
//  Created by 平井　登惟 on 2026/09/09.
//

import UIKit

@IBDesignable
class BorderBtnController: UIButton {
    
    @IBInspectable var BorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var BorderColor: UIColor? {
        get {
            if let Color = layer.borderColor {
                return UIColor(cgColor: Color)
            }
            return nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable var Radius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
