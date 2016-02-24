//
//  customButton.swift
//  school
//
//  Created by 張翔 on 2016/01/11.
//  Copyright © 2016年 sho. All rights reserved.
//

import UIKit

@IBDesignable
class customButton: UIButton {
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clearColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
