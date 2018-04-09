//
//  AppFont.swift
//  AndroidLiketextField
//
//  Created by Manish Kumar on 09/04/18.
//  Copyright © 2018 Innofied. All rights reserved.
//

import Foundation

import Foundation
import UIKit

/*
 Lato-Regular
 Lato-Semibold
 Lato-Hairline
 Lato-Thin
 Lato-HairlineItalic
 Lato-Medium
 Lato-ThinItalic
 Lato-LightItalic
 Lato-Italic
 Lato-Bold
 Lato-SemiboldItalic
 Lato-BoldItalic
 Lato-MediumItalic
 Lato-Black
 Lato-HeavyItalic
 Lato-Light
 Lato-BlackItalic
 Lato-Heavy
 */
enum OSBFont {
    
    enum FontSize: Double {
        case h1 = 18.0
        case h2 = 16.0
        case h3 = 14.0
        case h4 = 13.0
        case h5 = 12.0
        case h6 = 11.0
        case h7 = 10.0
        case h8 = 9.0
        case h9 = 8.0
    }
    
    case lato_regular(FontSize)
    case lato_semibold(FontSize)
    case lato_hairline(FontSize)
    case lato_thin(FontSize)
    case lato_hairlineItalic(FontSize)
    case lato_medium(FontSize)
    case lato_thinItalic(FontSize)
    case lato_light(FontSize)
    case lato_italic(FontSize)
    case lato_lightItalic(FontSize)
    case lato_bold(FontSize)
    case lato_semiboldItalic(FontSize)
    case lato_boldItalic(FontSize)
    case lato_mediumItalic(FontSize)
    case lato_black(FontSize)
    case lato_heavyItalic(FontSize)
    case lato_blackItalic(FontSize)
    case lato_heavy(FontSize)
    
    var value: UIFont {
        
        var font: UIFont!
        switch self {
        case .lato_regular(let size):
            font = UIFont(name: "HelveticaNeue", size: CGFloat(size.rawValue))
        case .lato_semibold(let size):
            font = UIFont(name: "HelveticaNeue", size: CGFloat(size.rawValue))
        case .lato_hairline(let size):
            font = UIFont(name: "HelveticaNeue", size: CGFloat(size.rawValue))
        case .lato_thin(let size):
            font = UIFont(name: "HelveticaNeue", size: CGFloat(size.rawValue))
        case .lato_hairlineItalic(let size):
            font = UIFont(name: "HelveticaNeue", size: CGFloat(size.rawValue))
        case .lato_medium(let size):
            font = UIFont(name: "HelveticaNeue", size: CGFloat(size.rawValue))
        case .lato_thinItalic(let size):
            font = UIFont(name: "HelveticaNeue", size: CGFloat(size.rawValue))
        case .lato_light(let size):
            font = UIFont(name: "HelveticaNeue", size: CGFloat(size.rawValue))
        case .lato_italic(let size):
            font = UIFont(name: "HelveticaNeue", size: CGFloat(size.rawValue))
        case .lato_lightItalic(let size):
            font = UIFont(name: "HelveticaNeue", size: CGFloat(size.rawValue))
        case .lato_bold(let size):
            font = UIFont(name: "HelveticaNeue", size: CGFloat(size.rawValue))
        case .lato_semiboldItalic(let size):
            font = UIFont(name: "HelveticaNeue", size: CGFloat(size.rawValue))
        case .lato_boldItalic(let size):
            font = UIFont(name: "HelveticaNeue", size: CGFloat(size.rawValue))
        case .lato_mediumItalic(let size):
            font = UIFont(name: "HelveticaNeue", size: CGFloat(size.rawValue))
        case .lato_black(let size):
            font = UIFont(name: "HelveticaNeue", size: CGFloat(size.rawValue))
        case .lato_heavyItalic(let size):
            font = UIFont(name: "HelveticaNeue", size: CGFloat(size.rawValue))
        case .lato_blackItalic(let size):
            font = UIFont(name: "HelveticaNeue", size: CGFloat(size.rawValue))
        case .lato_heavy(let size):
            font = UIFont(name: "HelveticaNeue", size: CGFloat(size.rawValue))
            
        }
        return font
    }
}

