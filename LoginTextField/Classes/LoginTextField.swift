//
//  LoginTextField.swift
//  LoginTextField
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
    open let imgView = UIImageView()
    open let seperatorLineView = UIView()
    open var passwordAppearanceButton : UIButton?

    
    ///Left image of the LogintextField.
    ///Setting this is mandatory, or you will see an empty area at the left of your LogintextField.
    @IBInspectable
    open var image : UIImage? {
        set{
            guard let image = newValue else{
                imgView.image = nil
                return
            }
            imgView.image = image.withRenderingMode(.alwaysTemplate)
        }
        get{
            return imgView.image
        }
    }
    
    ///Left image color of the LogintextField. Also used for "show/hide password button" tint color.
    /// Default value is UIColor.black
    @IBInspectable
    open var defaultColor : UIColor = UIColor.black{
        didSet{
            imgView.tintColor = defaultColor
            if isSecureTextEntry && showPasswordApperanceButton{
                passwordAppearanceButton?.tintColor = defaultColor
            }
        }
    }
    
    ///LogintextField's placeholder text color.
    ///Default value is UIColor.white
    @IBInspectable
    open var placeholderColor : UIColor = UIColor.white{
        didSet{
            setPlaceholder()
        }
    }
    
    open override var placeholder: String?{
        didSet{
            setPlaceholder()
        }
    }
    
    ///Creates attributedPlaceholder
    fileprivate func setPlaceholder(){
        guard let placeholder = placeholder else{
            return
        }
        attributedPlaceholder = NSAttributedString.init(string: placeholder, attributes: [NSAttributedStringKey.font : font!, NSAttributedStringKey.foregroundColor : placeholderColor])
    }
    
    ///LogintextField's error text color.
    ///It's default value is UIColor.red
    @IBInspectable
    open var errorColor : UIColor = UIColor.red
    
    
    ///LogintextField's borderWidth when error is shown
    ///It's default value is 0
    @IBInspectable
    open var errorBorderWidth : CGFloat = 0
    
    ///LoginTextField's seperator line color.
    ///Default value is black
    @IBInspectable
    open var seperatorLineColor : UIColor = UIColor.black{
        didSet{
            seperatorLineView.backgroundColor = seperatorLineColor
        }
    }
    
    ///Creates LoginTextField show/hide password button
    ///Default value is black
    @IBInspectable
    open var showPasswordApperanceButton : Bool = false{
        didSet{
            if showPasswordApperanceButton{
                if isSecureTextEntry{
                    passwordAppearanceButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: frame.size.height, height: frame.size.height))
                    passwordAppearanceButton?.setImage(UIImage.init(named: "eye-open", in: Bundle.init(for: type(of: self)), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate), for: .normal)
                    passwordAppearanceButton?.tintColor = defaultColor
                    passwordAppearanceButton?.addTarget(self, action: #selector(handlePasswordAppearenceButtonClick(_:)), for: .touchUpInside)
                    passwordAppearanceButton?.tintColor = defaultColor
                    rightView = passwordAppearanceButton
                    rightViewMode = .always
                }
            }
            else{
                rightView = nil
            }
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
    open var borderColor : UIColor = UIColor.black{
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
        
        leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: self.frame.size.height * 5 / 4, height: self.frame.size.height))
        
        imgView.frame = CGRect(x: self.frame.size.height/4, y: self.frame.size.height/4, width: self.frame.size.height/2, height: self.frame.size.height/2)
        imgView.contentMode = .scaleAspectFit
        imgView.tag = 1
        leftView!.addSubview(imgView)

        seperatorLineView.frame = CGRect(x: self.frame.size.height, y: 5, width: 0.5, height: self.frame.size.height - 10)
        seperatorLineView.tag = 2
        seperatorLineView.backgroundColor = seperatorLineColor
        leftView!.addSubview(seperatorLineView)
        
        self.leftViewMode = .always
        imgView.tintColor = defaultColor
        seperatorLineView.backgroundColor = defaultColor
    }
    
    ///Funtion to handle show/hide password
    @objc fileprivate func handlePasswordAppearenceButtonClick(_ sender: UIButton){
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
        
        imgView.tintColor = isValid ? defaultColor : errorColor
        seperatorLineView.backgroundColor = isValid ? seperatorLineColor : errorColor
        layer.borderWidth = isValid ? borderWidth : errorBorderWidth
        layer.borderColor = isValid ? borderColor.cgColor : errorColor.cgColor
        
    }
}



