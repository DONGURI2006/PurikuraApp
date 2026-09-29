//
//  MarkerView.swift
//  PurikuraApp
//
//  Created by 平井　登惟 on 2026/09/28.
//

import UIKit

protocol MarkerViewDelegate: AnyObject
{
    func MarkerViewDragStart(markerCellImage: MarkerView, location:CGPoint)
    func MarkerViewChange(markerCellImage: MarkerView, location:CGPoint)
    func MarkerViewStop(markerCellImage: MarkerView, location:CGPoint)
}


class MarkerView: UIImageView{
    weak var delegate: MarkerViewDelegate?
    var markerName = ""
    
    
    override func awakeFromNib()
    {
        self.isUserInteractionEnabled = true
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture(gestureRecognizer:)))
        self.addGestureRecognizer(panGestureRecognizer)
        self.frame.size = CGSize(width: 128, height: 128)
    }
        
    @objc func panGesture(gestureRecognizer: UIPanGestureRecognizer)
    {
        let locationInView = gestureRecognizer.location(in: self.window)
        
        switch (gestureRecognizer.state)
        {
            case .began:
                self.delegate?.MarkerViewDragStart(markerCellImage: self, location: locationInView)
            case .changed:
                self.delegate?.MarkerViewChange(markerCellImage: self, location: locationInView)
            case .ended:
                self.delegate?.MarkerViewStop(markerCellImage: self, location: locationInView)
            default:
                break
        }
    }
    
}
