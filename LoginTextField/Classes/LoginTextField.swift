//
//  LoginTextField.swift
//  Acar Tahsilat
//
//  Created by Arda Oğul Üçpınar on 12.12.2017.
//  Copyright © 2017 Avorna Yazılım Ltd. Şti. All rights reserved.
//

import UIKit

/**
 LogintextField is a tiny subclass of UITextField, especially to use in a login/registration forms.
 What you can do with LoginTextField are:
    * You can easily set left images
    * You can set easily corner radius
    * You can set easyliy borderWidth and borderColor
    * If you use secure text entry, it has a button to show / hide password.
    * It has a seperator between left image and text, and it's color is changeable too.
    * Built-in error handling for validation. You can do validation easily with [Validator](https://github.com/adamwaite/Validator "Validor") dependency by Adam Waite.
    * All variables can be changed via Interface Builder.
 */
open class LoginTextField: UITextField {
    
    ///Left image of the LogintextField.
    ///Setting this is mandatory, or you will see an empty area at the left of your LogintextField.
    @IBInspectable
    open var image : UIImage? {
        didSet{
            guard let logoView = leftView?.viewWithTag(1) as? UIImageView else{
                print("[LoginFormTextField] [\(#function)] logoView is not initialized.")
                return
            }
            guard let image = image else{
                logoView.image = nil
                return
            }
            logoView.image = image.withRenderingMode(.alwaysTemplate)
        }
    }
    
    ///Left image color of the LogintextField. Also used for "show/hide password button" tint color.
    /// Default value is UIColor.black
    @IBInspectable
    open var imageColor : UIColor = UIColor.black{
        didSet{
            guard let logoView = leftView?.viewWithTag(1) as? UIImageView else{
                print("[LoginFormTextField] [\(#function)] logoView is not initialized.")
                return
            }
            logoView.tintColor = imageColor
            if isSecureTextEntry{
                guard let eyeButton = rightView as? UIButton else{
                    print("[LoginFormTextField] [\(#function)] eyeButton is not initialized.")
                    return
                }
                eyeButton.tintColor = imageColor
            }
        }
    }
    
    ///LogintextField's placeholder text color.
    ///Default value is UIColor.white
    @IBInspectable
    open var placeholderColor : UIColor = UIColor.white{
        didSet{
            if let placeholder = placeholder{
                attributedPlaceholder = NSAttributedString.init(string: placeholder, attributes: [NSAttributedStringKey.font : font ?? UIFont.italicSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor : placeholderColor])
            }
        }
    }
    
    ///LogintextField's error text color.
    ///It's default value is UIColor.red
    @IBInspectable
    open var errorColor : UIColor = UIColor.red
    
    
    ///LogintextField's borderWidth when error is shown
    ///It's default value is 0
    @IBInspectable
    open var errorBorderWidth : CGFloat = 0{
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    ///LoginTextField's seperator line color.
    ///Default value is black
    @IBInspectable
    open var lineColor : UIColor = UIColor.black{
        didSet{
            guard let line = leftView?.viewWithTag(2) else{
                print("[LoginFormTextField] [\(#function)] line is not initialized.")
                return
            }
            line.backgroundColor = lineColor
        }
    }
    
    
    ///LogintextField's cornerRadius
    ///It's default value is 3
    @IBInspectable
    open var cornerRadius : CGFloat = 3{
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    
    ///LogintextField's borderWidth
    ///It's default value is 0
    @IBInspectable
    open var borderWidth : CGFloat = 0{
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    ///LogintextField's borderColor
    ///It's default value is UIColor.clear
    @IBInspectable
    open var borderColor : UIColor = UIColor.clear{
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    ///Function called by all initialization functions to set-up LogintextField.
    fileprivate func commonInit(){
        borderStyle = .none
        let logoContainer = UIView.init(frame: CGRect(x: 0, y: 0, width: self.frame.size.height * 5 / 4, height: self.frame.size.height))
        let logoView = UIImageView.init(frame: CGRect(x: self.frame.size.height/4, y: self.frame.size.height/4, width: self.frame.size.height/2, height: self.frame.size.height/2))
        logoView.contentMode = .scaleAspectFit
        logoView.tag = 1
        logoContainer.addSubview(logoView)
        
        let line = UIView.init(frame: CGRect(x: self.frame.size.height, y: 5, width: 0.5, height: self.frame.size.height - 10))
        line.tag = 2
        line.backgroundColor = lineColor
        logoContainer.addSubview(line)
        
        self.leftView = logoContainer
        self.leftViewMode = .always
        
        if isSecureTextEntry{
            let button = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: frame.size.height, height: frame.size.height))
            button.setImage(UIImage.init(named: "eye-open", in: Bundle.init(for: type(of: self)), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate), for: .normal)
            button.tintColor = imageColor
            button.addTarget(self, action: #selector(handleEyeButtonClick(_:)), for: .touchUpInside)
            rightView = button
            rightViewMode = .always
        }
    }
    
    ///Funtion to handle show/hide password
    @objc fileprivate func handleEyeButtonClick(_ sender: UIButton){
        if isSecureTextEntry{
            sender.setImage(UIImage.init(named: "eye-close", in: Bundle.init(for: type(of: self)), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        else{
            sender.setImage(UIImage.init(named: "eye-open", in: Bundle.init(for: type(of: self)), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        isSecureTextEntry = !isSecureTextEntry
    }
    
    ///To handling validation errors.
    ///You can show error inside the LoginTextView using this function.
    /// - parameter isValid: Boolean value that indicates validation is successful or not.
    public func handleError(isValid : Bool){
        guard let logoView = leftView?.viewWithTag(1) as? UIImageView else{
            print("[LoginFormTextField] [\(#function)] logoView is not initialized.")
            return
        }
        
        guard let line = leftView?.viewWithTag(2) else{
            print("[LoginFormTextField] [\(#function)] lineView is not initialized.")
            return
        }
        
        logoView.tintColor = isValid ? imageColor : errorColor
        line.backgroundColor = isValid ? lineColor : errorColor
        layer.borderWidth = isValid ? borderWidth : errorBorderWidth
        layer.borderColor = isValid ? borderColor.cgColor : errorColor.cgColor
        
    }
}



