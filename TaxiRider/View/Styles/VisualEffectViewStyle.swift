//
//  VisualEffectViewStyle.swift
//  Photo Album Generator
//
//  Created by PowerMobile on 1/8/18.
//  Copyright © 2018 PowerMobile. All rights reserved.
//

import UIKit

@IBDesignable
class VisualEffectViewStyle: UIVisualEffectView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

}
