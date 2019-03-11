//
//  UIImageViewX.swift
//  Spotless
//
//  Created by PowerMobile on 3/13/18.
//  Copyright © 2018 PowerMobile. All rights reserved.
//

import UIKit
@IBDesignable

class UIImageViewX: UIImageView {
    
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable  var borderWidth : CGFloat = 1 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable  var borderColor : UIColor = UIColor.blue {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    
}

