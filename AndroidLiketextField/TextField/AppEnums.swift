//
//  AppEnums.swift
//  AndroidLiketextField
//
//  Created by Manish Kumar on 09/04/18.
//  Copyright © 2018 Innofied. All rights reserved.
//

import Foundation
import UIKit

public enum SideMenuAppOptions : String{
    
    case home = "HOME"
    case settings = "SETTINGS"
    case logout = "LOGOUT"
    
    
    var value: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
    
    static let enumArray = [home, settings, logout]
    
    
    static let count: Int = {
        return SideMenuAppOptions.logout.hashValue + 1
    }()
    
    static func valueAtIndex(index : Int) -> String {
        return SideMenuAppOptions.enumArray[index].value
    }
    
}


enum TextInputFieldValidityStatus: Int {
    case notChecked
    case valid
    case invalid
    case empty
    //case error(reason: String)
}


enum TextInputFieldType : Int {
    case name // 0
    case email // 1
    case phone // 2
    case password // 3
    case otpDigit // 4
    case nameComponent // 5 // First Name, Middle Name
    case confirmPassword // 6
    case emailOrPhoneNumber //7
    
    var regex: String {
        switch self {
        case .name:
            return "^([a-zA-z]+\\s?)*\\s*$"//"^[a-zA-Z ]{1,30}$"
        case .email:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        case .phone:
            return "\\d{10}" //"[2-9]{1}\\d{9}" // // 10 Digit First 1 digit is not 0 or 1
        case .password, .confirmPassword:
            return  "^(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d@$!%*?&]{8,}$"
        // Atleast one upper, one lower one digit
        case .otpDigit:
            return "\\d{1}" // Exact one digit
        case .nameComponent:
            return "^[a-zA-Z ]{1,30}$"
        case .emailOrPhoneNumber:
            return ""
        }
    }
}

enum OSBTextFieldEvent {
    case editingStart
    case editing
    case editingEnd
}



protocol OSBUITextFieldDelegate: class {
    func textFieldDidReceiveBackspace(field: UITextField)
}
protocol OSBTextFieldDelegate: class {
    func textFieldDidReceiveBackspace(field: OSBTextField)
}

protocol OSBTextFieldValidityDelegate: class {
    func textField(_ textField: OSBTextField, didChangeValididyStatus status: TextInputFieldValidityStatus)
}
//protocol BRTextFieldEditingDelegate: class {
//    func textField(_ textField : BRPlaceHolderTextField, stringEntered : String)
//}
//
//protocol BROTPTextFieldDelegate: class {
//    func otpFieldDidBecomeValid(otpField: BROTPTextField, withText text: String)
//    func otpFieldDidBecomeInvalid(otpField: BROTPTextField)
//    func otpFieldReceivedBackspace(otpField: BROTPTextField)
//    func otpFieldNextDidBecomeValid(otpField: BROTPTextField, withText text: String)
//    func otpFieldPrevioudDidBecomeValid(otpField: BROTPTextField)
//
//}
//protocol BRFragmentTextFieldDelegate: class {
//    func fragmentFieldDidBecomeValid(field: BRFragmentTextField, withText text: String)
//    func fragmentFieldDidBecomeInValid(field: BRFragmentTextField, withText text: String)
//}
//protocol BROTPTextFieldStackValidityDelegate: class {
//    func otpStack(stack: BROTPTextFieldStack, didChangeValidityStatus validity: TextInputFieldValidityStatus)
//}
//protocol BRFragmentTextFieldStackValidityDelegate: class {
//    func fragmentStack(stack: BRFragmentTextFieldStack, didChangeValidityStatus validity: TextInputFieldValidityStatus)
//}
//
//protocol BRDropDownTextFieldDelegate: class {
//    func textFieldDidBiginEditing(dropDownTextField: BRPlaceHolderTextField)
//}
//
//protocol BRTextFieldTapDelegate: class {
//    func textFieldWillBeginEditing(_ textField: BRAddressTextField)
//}
