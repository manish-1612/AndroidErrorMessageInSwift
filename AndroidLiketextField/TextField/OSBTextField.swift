//
//  File.swift
//  AndroidLiketextField
//
//  Created by Manish Kumar on 09/04/18.
//  Copyright © 2018 Innofied. All rights reserved.
//

import Foundation
import UIKit

class OSBTextField: UITextField {
    
    weak var eventDelegate: OSBUITextFieldDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = OSBFont.lato_regular(.h4).value
        self.textColor = OSBColor.white.value
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = OSBFont.lato_regular(.h4).value
        self.textColor = OSBColor.white.value
    }
    
    override func deleteBackward() {
        super.deleteBackward()
        self.eventDelegate?.textFieldDidReceiveBackspace(field: self)
    }
    
}
