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
        
        let PinchGesture = UIPinchGestureRecognizer(target: self,action: #selector(HandlePinch(_:)))
        self.addGestureRecognizer(PinchGesture)
        
        let LongPressGesture = UILongPressGestureRecognizer(target: self,action: #selector(OnLongPress(gestureRecognizer:)))
        self.addGestureRecognizer(LongPressGesture)
        
        let RotationGesture = UIRotationGestureRecognizer(target: self,action: #selector(HandleRotation(_:)))
        self.addGestureRecognizer(RotationGesture)
        
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
    
    @objc func OnLongPress(gestureRecognizer: UILongPressGestureRecognizer)
    {
        UIView.animate(withDuration: 0.7) {
            
            self.transform = CGAffineTransform(scaleX: 0, y: 0)
            self.alpha = 0
            
        }

    }
    @objc func HandleRotation(_ gesture: UIRotationGestureRecognizer) {
            if gesture.state == .changed {
                self.transform = self.transform.rotated(by: gesture.rotation)

                gesture.rotation = 0
            }

            if gesture.state == .ended {
                delegate?.didMoveMarker()
            }
        }

    @objc func HandlePinch(_ gesture: UIPinchGestureRecognizer)
    {

        guard gesture.view != nil else { return }

        if gesture.state == .changed {
                
            self.transform = self.transform.scaledBy(x: gesture.scale,y: gesture.scale)
            gesture.scale = 1.0
        }

        if gesture.state == .ended {
            delegate?.didMoveMarker()
        }
    }
    
    class func createMarker(image: UIImage) -> MarkerBase?
    {
        let marker = MarkerBase(image: image)
        
        return marker
    }
}
