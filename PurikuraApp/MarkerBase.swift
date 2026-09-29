//
//  MarkerBase.swift
//  PurikuraApp
//
//  Created by 平井　登惟 on 2026/09/29.
//

import UIKit

protocol MarkerDelegate: AnyObject
{
    func didMoveMarker()
}

class MarkerBase: UIImageView{
    weak var delegate:MarkerDelegate?
    private var isDragging = false
    
    override init(image: UIImage?){
        super.init(image: image)
                
        self.isUserInteractionEnabled = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        guard let touch = touches.first else { return }
        guard let superview = superview else { return }
        
        self.isDragging = true
        
        self.center = touch.location(in: superview)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesEnded(touches, with: event)
        
        if (self.isDragging)
        {
            self.isDragging = false
            self.delegate?.didMoveMarker()
        }
    }
    
    @objc func onLongPress(gestureRecognizer: UILongPressGestureRecognizer)
    {
        UIView.animate(withDuration: 0.7) {
            
            self.transform = CGAffineTransform(scaleX: 0, y: 0)
            self.alpha = 0
            
        }

    }
    class func createMarker(image: UIImage) -> MarkerBase?
    {
        let marker = MarkerBase(image: image)
        
        return marker
    }
}
