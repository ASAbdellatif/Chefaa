//
//  Extension.swift
//  ChefaaApp
//
//  Created by Ayman Salah on 8/21/20.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit


extension UIView {
    
    public func roundCorners(radius: CGFloat, borderWidth: Int? = nil, borderColor: UIColor? = nil) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        
        self.layer.borderColor = borderColor?.cgColor
        self.layer.borderWidth = CGFloat(borderWidth ?? 0)
        self.layer.masksToBounds = true
    }

}

