//
//  OSBTextFieldView.swift
//  AndroidLiketextField
//
//  Created by Manish Kumar on 09/04/18.
//  Copyright © 2018 Innofied. All rights reserved.
//

import Foundation
import UIKit

class OSBTextFieldView: UIView {
    
    var parentView: UIView!
    var viewForError : UIView?
    var textField: OSBTextField?

    @IBOutlet weak var buttonForError: UIButton!
    
    @IBInspectable
    var inputType: Int = TextInputFieldType.name.rawValue {
        didSet {
            layoutSubviews()
        }
    }
    
    @IBInspectable
    var validationMessageForInvalidInput: String = "Please enter a valid email" {
        didSet {
            layoutSubviews()
        }
    }
    
    @IBInspectable
    var isRequiredOnly: Bool = false {
        didSet {
            layoutSubviews()
        }
    }
    @IBInspectable
    var isRequired: Bool = true {
        didSet {
            layoutSubviews()
        }
    }
    
    
    weak var validityDelegate: OSBTextFieldValidityDelegate?
    weak var editDelegate:  OSBTextFieldDelegate?
    
    var shouldBeginEditing: Bool = true
    var validityStatus: TextInputFieldValidityStatus = .notChecked {
        didSet {
            
        }
    }
    
    var isValid: Bool {
        return validityStatus == .valid
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        createTextField()
        setUpTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        createTextField()
        setUpTextField()
    }
    
    func xibSetup() {
        parentView = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        parentView.frame = bounds
        
        // Make the view stretch with containing view
        parentView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(parentView)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "OSBTextFieldView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }

    // MARK: - View Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpTextField()
    }
    
    
    // MARK: TEXT FIELD FUNCTIONS
    func createTextField(){
        //create textField
        self.textField = OSBTextField()
        self.textField?.delegate = self
        self.addSubview(self.textField!)
    }
    
    func setUpTextField() {
        textField?.frame = CGRect(x: 18.0, y: 0.0, width: self.frame.width - (30.0 + 17.0), height: self.frame.height)
        setupTapRecogniser()
        setKeyboard(type: TextInputFieldType(rawValue:inputType)!)
    }
    
    func setupTapRecogniser(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedOnView(tapGesture:)))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tap)
        
        self.textField?.addGestureRecognizer(tap)
    }
    
    
    @objc func tappedOnView(tapGesture: UITapGestureRecognizer){
        
        //hideErrorLayer()
    }
    
    private func setKeyboard(type: TextInputFieldType) {
        switch type {
        case .name, .nameComponent:
            self.textField?.keyboardType = .default
            self.textField?.autocorrectionType = .no
            self.textField?.autocapitalizationType = .words
        case .email:
            self.textField?.keyboardType = .emailAddress
            self.textField?.autocorrectionType = .no
            self.textField?.autocapitalizationType = .none
        case .phone:
            self.textField?.keyboardType = .numberPad
        case .password, .confirmPassword:
            self.textField?.keyboardType = .default
            self.textField?.isSecureTextEntry = true
        case .otpDigit:
            self.textField?.keyboardType = .numberPad
        case .emailOrPhoneNumber:
            self.textField?.keyboardType = .default
        }
    }
    
    
    @IBAction func errorButtonClicked(_ sender: UIButton) {
        
        drawErrorView()
    }
    
}


extension OSBTextFieldView: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        hideErrorLayer()
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        checkValidity(text: text, event: .editing)
        
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkValidity(text: textField.text, event: .editingEnd)
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return shouldBeginEditing
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    
}

extension OSBTextFieldView {
    
    public func checkValidity(text: String?, event: OSBTextFieldEvent) {
        
        self.validityStatus = isTextValid(text: text, event: event)
        self.buttonForError.isHidden = isValid
        validityDelegate?.textField(self.textField!, didChangeValididyStatus: self.validityStatus)
        
    }
    
    func isTextValid(text: String?, event: OSBTextFieldEvent) -> TextInputFieldValidityStatus {
        
        guard let text = text, text.count > 0 else {
            validityDelegate?.textField(self.textField!, didChangeValididyStatus: .empty)
            return .empty
        }
        
        if isRequiredOnly {
            // Only empty field checking
            validityDelegate?.textField(self.textField!, didChangeValididyStatus: .valid)
            return .valid
        }
        
        let textInputType = TextInputFieldType(rawValue: inputType)!
        if textInputType.regex.count > 0{
            let textPredicate = NSPredicate(format:"SELF MATCHES %@", textInputType.regex)
            let status = textPredicate.evaluate(with: text)
            return (status ? .valid : .invalid)
        }else{
            return .valid
        }
    }
    
    
}

extension OSBTextFieldView {
    
    func drawErrorView(){
        
        if viewForError == nil{
            
            let pathForError = getPathForFullErrorLayer()
            let layerForError = CAShapeLayer()
            layerForError.path = pathForError.cgPath
            layerForError.fillColor = UIColor.black.cgColor

            let redArrowPath = getPathForArrowRedLayer()
            let layerForRedArrow = CAShapeLayer()
            layerForRedArrow.path = redArrowPath.cgPath
            layerForRedArrow.fillColor = UIColor.red.cgColor
            
            viewForError = UIView()
            viewForError!.layer.addSublayer(layerForError)
            viewForError!.layer.addSublayer(layerForRedArrow)
            
            let label = UILabel()
            let width = validationMessageForInvalidInput.width(withConstrainedHeight: 35.0, font: OSBFont.lato_regular(.h5).value)
            let pointInSuperView = self.convert(buttonForError.frame.origin, to: self.superview)

            label.frame = CGRect(x: pointInSuperView.x + 20.0 - width , y: pointInSuperView.y + 40.0, width: 0.0, height: 0.0)
            label.backgroundColor = UIColor.clear
            label.text = validationMessageForInvalidInput
            label.font = OSBFont.lato_regular(.h5).value
            label.textColor = OSBColor.white.value
            label.sizeToFit()
            label.numberOfLines = 0
            viewForError?.addSubview(label)
        

            
            if self.superview != nil{
                self.superview?.addSubview(viewForError!)
                self.bringSubview(toFront: viewForError!)
            }
            
        }else{
            viewForError!.removeFromSuperview()
            viewForError = nil
        }
    }
    
    func getPathForFullErrorLayer() -> UIBezierPath{
        let width = validationMessageForInvalidInput.width(withConstrainedHeight: 35.0, font: OSBFont.lato_regular(.h5).value) + 20.0

        let startingPoint = CGPoint(x: self.frame.size.width - 15.0 , y: (self.frame.size.height/2.0 + 10.0))
        
        let pointInSuperView = self.convert(startingPoint, to: self.superview)
        
        let pathForError = UIBezierPath()
        pathForError.move(to: pointInSuperView)
        pathForError.addLine(to: CGPoint(x: pointInSuperView.x + 5.0, y:(pointInSuperView.y +  5.0)))
        pathForError.addLine(to: CGPoint(x: pointInSuperView.x + 15.0, y:(pointInSuperView.y +  5.0)))
        pathForError.addLine(to: CGPoint(x: pointInSuperView.x + 15.0, y:(pointInSuperView.y +  35.0)))
        pathForError.addLine(to: CGPoint(x: pointInSuperView.x + 15.0 - width , y:(pointInSuperView.y +  35.0)))
        pathForError.addLine(to: CGPoint(x: pointInSuperView.x + 15.0 - width , y:(pointInSuperView.y +  5.0)))
        pathForError.addLine(to: CGPoint(x: pointInSuperView.x - 5.0 , y:(pointInSuperView.y +  5.0)))
        pathForError.close()
        
        return pathForError

    }
    
    func getPathForArrowRedLayer() -> UIBezierPath{
        
        let width = validationMessageForInvalidInput.width(withConstrainedHeight: 35.0, font: OSBFont.lato_regular(.h5).value) + 20.0

        let startingPoint = CGPoint(x: self.frame.size.width - 15.0 , y: (self.frame.size.height/2.0 + 10.0))
        let pointInSuperView = self.convert(startingPoint, to: self.superview)
        
        let redArrowPath = UIBezierPath()
        redArrowPath.move(to: pointInSuperView)
        redArrowPath.addLine(to: CGPoint(x: pointInSuperView.x + 5.0, y:(pointInSuperView.y +  5.0)))
        redArrowPath.addLine(to: CGPoint(x: pointInSuperView.x + 15.0, y:(pointInSuperView.y +  5.0)))
        redArrowPath.addLine(to: CGPoint(x: pointInSuperView.x + 15.0, y:(pointInSuperView.y +  10.0)))
        redArrowPath.addLine(to: CGPoint(x: pointInSuperView.x + 15.0 - width , y:(pointInSuperView.y +  10.0)))
        redArrowPath.addLine(to: CGPoint(x: pointInSuperView.x + 15.0 - width , y:(pointInSuperView.y +  5.0)))
        redArrowPath.addLine(to: CGPoint(x: pointInSuperView.x - 5.0 , y:(pointInSuperView.y +  5.0)))
        redArrowPath.close()

        return redArrowPath
    }

    func hideErrorLayer(){
        if viewForError != nil{
            viewForError!.removeFromSuperview()
            viewForError = nil
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        hideErrorLayer()
    }
    
    
    
}
