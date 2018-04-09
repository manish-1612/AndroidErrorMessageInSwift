//
//  AppColor.swift
//  AndroidLiketextField
//
//  Created by Manish Kumar on 09/04/18.
//  Copyright © 2018 Innofied. All rights reserved.
//

import Foundation
import UIKit


enum OSBColor {
    case black
    case white
    
    // Common UI
    case themeBlue
    case textFieldPlaceHolderColor
    case navBarColour
    
    
    var value : UIColor {
        var color: UIColor = .white
        switch self {
            
        case .black:
            color = UIColor(hexString: "#000000")
            
        case .white:
            color = UIColor(hexString: "#FFFFFF")
            
        case .themeBlue:
            color = UIColor(hexString: "#00C0DE")
            
        case .textFieldPlaceHolderColor:
            color = UIColor(hexString: "#64F6FF")
            
        case .navBarColour:
            color = UIColor(hexString: "#00ACC6")
        }
        
        
        
        return color
    }
    
    func withAlpha(_ alpha: Double) -> UIColor {
        switch alpha {
        case 0.0...1.0:
            return self.value.withAlphaComponent(CGFloat(alpha))
        default:
            fatalError("Alpha component must be within 0.0-1.0")
        }
    }
}

