//
//  LoginTextField.swift
//  Acar Tahsilat
//
//  Created by Arda Oğul Üçpınar on 12.12.2017.
//  Copyright © 2017 Avorna Yazılım Ltd. Şti. All rights reserved.
//

import UIKit

open class LoginTextField: UITextField {
    
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
    
    @IBInspectable
    open var imageColor : UIColor?{
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
    
    @IBInspectable
    open var placeholderColor : UIColor = UIColor.white{
        didSet{
            if let placeholder = placeholder{
                attributedPlaceholder = NSAttributedString.init(string: placeholder, attributes: [NSAttributedStringKey.font : font ?? UIFont.italicSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor : placeholderColor])
            }
        }
    }
    
    @IBInspectable
    open var imageErrorColor : UIColor = UIColor.red
    
    @IBInspectable
    open var lineColor : UIColor = UIColor.white{
        didSet{
            guard let line = leftView?.viewWithTag(2) else{
                print("[LoginFormTextField] [\(#function)] line is not initialized.")
                return
            }
            line.backgroundColor = lineColor
        }
    }
    
    
    
    @IBInspectable
    open var cornerRadius : CGFloat = 3{
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable
    open var borderWidth : CGFloat = 0{
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
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
    
    open override func tintColorDidChange() {
        
    }
    
    fileprivate func commonInit(){
        
        let logoContainer = UIView.init(frame: CGRect(x: 0, y: 0, width: self.frame.size.height * 9 / 7, height: self.frame.size.height))
        let logoView = UIImageView.init(frame: CGRect(x: self.frame.size.height/4, y: self.frame.size.height/4, width: self.frame.size.height/2, height: self.frame.size.height/2))
        logoView.contentMode = .scaleAspectFit
        logoView.tag = 1
        logoContainer.addSubview(logoView)
        
        let line = UIView.init(frame: CGRect(x: self.frame.size.height/8*7 + 10, y: 5, width: 0.5, height: self.frame.size.height - 10))
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
    
    @objc fileprivate func handleEyeButtonClick(_ sender: UIButton){
        if isSecureTextEntry{
            sender.setImage(UIImage.init(named: "eye-close", in: Bundle.init(for: type(of: self)), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        else{
            sender.setImage(UIImage.init(named: "eye-open", in: Bundle.init(for: type(of: self)), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        isSecureTextEntry = !isSecureTextEntry
    }
    
    public func handleError(isValid : Bool){
        guard let logoView = leftView?.viewWithTag(1) as? UIImageView else{
            print("[LoginFormTextField] [\(#function)] logoView is not initialized.")
            return
        }
        
        guard let line = leftView?.viewWithTag(2) else{
            print("[LoginFormTextField] [\(#function)] lineView is not initialized.")
            return
        }
        
        logoView.tintColor = isValid ? imageColor : imageErrorColor
        line.backgroundColor = isValid ? lineColor : imageErrorColor
        layer.borderColor = isValid ? borderColor.cgColor : imageErrorColor.cgColor
    }
}



