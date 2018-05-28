//
//  KJSwipeButton.swift
//  KJSwipeButton
//
//  Created by Artifex on 28/05/18.
//  Copyright © 2018 Artifex. All rights reserved.
//

import UIKit

protocol KJSwipeButtonDelegate {
    func busttonStatusChange(status:Bool)
}

class KJSwipeButton: UIView {

    /*A Bool property return Switch is On or Off*/
    var isOn : Bool = false{
        didSet{
            if self.isOn{
                self.switchView.backgroundColor = self.trackOffTintColor
                self.switchThumb.backgroundColor = self.thumbOnTintColor
            } else {
                self.switchView.backgroundColor = self.trackOffTintColor
                self.switchThumb.backgroundColor = self.trackOnTintColor
            }
            self.switchView.layer.borderWidth = 1.0
            self.switchView.layer.borderColor = self.switchThumb.backgroundColor?.cgColor
        }
    }
    
    var isDisabled : Bool = false{
        didSet{
            if self.isOn{
                self.switchView.backgroundColor = self.trackDisabledTintColor
                self.switchThumb.backgroundColor = self.thumbDisabledTintColor
            } else {
                self.isOn = false
            }
        }
    }
    
    /*Delegate Method*/
    var delegate : KJSwipeButtonDelegate!
    
    /*Color Property*/
    /** An UIColor property to represent the colour of the switch thumb when position is ON */
    var thumbOnTintColor: UIColor!
    
    /** An UIColor property to represent the colour of the switch thumb when position is OFF */
    var thumbOffTintColor: UIColor!
    
    /** An UIColor property to represent the colour of the track when position is ON */
    var trackOnTintColor: UIColor!
    
    /** An UIColor property to represent the colour of the track when position is OFF */
    var trackOffTintColor: UIColor!
    
    /** An UIColor property to represent the colour of the switch thumb when position is DISABLED */
    var thumbDisabledTintColor: UIColor!
    
    /** An UIColor property to represent the colour of the track when position is DISABLED */
    var trackDisabledTintColor: UIColor!
   
    /*UIView for set Thumb*/
    var switchThumb : UIView!
    /*UIView for set Swith Back*/
    var switchView : UIView!
    
    /*GestureRecognizer*/
    var panGestureRecognizer : UIPanGestureRecognizer!
    var tapGestureRecognizer : UITapGestureRecognizer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init()
    }
    
    func setUIForSwitch(){
      
        
    }
    
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
    }
    
//    convenience init(isOn:Bool){
    func setStateOfView(isOn:Bool){
        
        
        //Create view
        self.switchView = UIView()
        self.switchThumb = UIView()
        
        //Set Frame Of Switch View
        self.switchView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        if isOn {
                self.switchThumb.frame = CGRect(x: 0, y: 0, width: self.switchView.frame.size.height, height: self.switchView.frame.size.height)
        }else{
            self.switchThumb.frame = CGRect(x: self.switchView.frame.size.width - self.switchView.frame.size.height, y: 0, width: self.switchView.frame.size.height, height: self.switchView.frame.size.height)
        }
        
        
        //Set Corner Radius
        self.switchView.layer.cornerRadius = self.switchView.frame.height / 2
        self.switchThumb.layer.cornerRadius = self.switchThumb.frame.height / 2
        
        //Set Clip to bound
        self.switchView.clipsToBounds = true
        self.switchThumb.clipsToBounds = true
        
        //Set Status
        self.isOn = isOn
        
        //add View
        self.switchView.addSubview(self.switchThumb)
        self.addSubview(self.switchView)
        
        //Pan GestureRecognizer
        self.panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(recognizer:)))
        self.switchThumb.addGestureRecognizer(self.panGestureRecognizer)
        
        
        //Tap GestureRecognizer
        self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(recognizer:)))
        self.switchView.addGestureRecognizer(self.tapGestureRecognizer)
    }
    
    @objc func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.switchView)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:self.switchView.frame.size.height / 2)
            
            if view.center.x < self.center.x{
                self.isOn = true
            } else {
                self.isOn = false
            }
            
        }
        if recognizer.state == .ended{
            self.moveThumb()
        }
        recognizer.setTranslation(CGPoint.zero, in: self.switchView)
    }
    
    @objc func handleTap(recognizer:UITapGestureRecognizer) {
        
        if recognizer.state == .ended {
            
            let touchLocation: CGPoint = recognizer.location(in: recognizer.view)
            if touchLocation.x < self.center.x && touchLocation.y < self.center.y{
                self.isOn = true
            } else {
                self.isOn = false
            }
            self.moveThumb()
        }
    }
    func moveThumb(){
        UIView.animate(withDuration: 0.2) {
            if self.isOn {
                self.switchThumb.frame = CGRect(x: 0, y: 0, width: self.switchView.frame.size.height, height: self.switchView.frame.size.height)
            }else{
                self.switchThumb.frame = CGRect(x: self.switchView.frame.size.width - self.switchView.frame.size.height, y: 0, width: self.switchView.frame.size.height, height: self.switchView.frame.size.height)
            }
        }
        if delegate != nil{
            delegate.busttonStatusChange(status: self.isOn)
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
