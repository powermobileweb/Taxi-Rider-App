//
//  TextFieldStyles.swift
//  Photo Album Generator
//
//  Created by PowerMobile on 11/17/17.
//  Copyright © 2017 PowerMobile. All rights reserved.
//

import UIKit
@IBDesignable
class TextFieldStyles: UITextField {

   
    @IBInspectable  var cornerRadious : CGFloat = 14 {
        didSet{
            self.layer.cornerRadius = cornerRadious
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

}
