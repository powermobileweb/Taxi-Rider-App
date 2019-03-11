//
//  ButtonStyles.swift
//  Photo Album Generator
//
//  Created by PowerMobile on 11/17/17.
//  Copyright © 2017 PowerMobile. All rights reserved.
//

import UIKit

 @IBDesignable
class ButtonStyles: UIButton {

  
    @IBInspectable  var cornerRadious : CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = cornerRadious
        }
    }
    
    @IBInspectable  var borderWidth : CGFloat = 0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable  var borderColor : UIColor = UIColor.blue {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }

    
    @IBInspectable public var shadowOpacity: CGFloat = 0 {
        didSet {
            layer.shadowOpacity = Float(shadowOpacity)
        }
    }
    
    @IBInspectable public var shadowColorLayer: UIColor = UIColor.clear {
        didSet {
            layer.shadowColor = shadowColorLayer.cgColor
        }
    }
    
    @IBInspectable public var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable public var shadowOfSetLayer: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            layer.shadowOffset = shadowOfSetLayer
        }
    }
    
    

}
