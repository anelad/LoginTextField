//
//  LoginTextFieldTest.swift
//  Acar Tahsilat
//
//  Created by Arda Oğul Üçpınar on 12.12.2017.
//  Copyright © 2017 Avorna Yazılım Ltd. Şti. All rights reserved.
//

import UIKit
import XCTest
import LoginTextField

class LoginTextFieldTest: XCTestCase {
    var testView : LoginTextField!
    
    override func setUp() {
        super.setUp()
        testView = LoginTextField.init(frame: CGRect.init(x: 0, y: 0, width: 150, height: 50))
        setSecureTextEntry(isSecureTextEnabled: true, showPasswordAppearence: true)
    }
    
    override func tearDown() {
        testView = nil
        super.tearDown()
    }
    
    ///Testing if default values are correct
    func testTextFieldInitialization() {
        XCTAssertNotNil(testView, "Test view is nil")
        XCTAssertEqual(CGRect.init(x: 0, y: 0, width: 150, height: 50), testView.frame, "Frames are not same")
    }
    
    func setSecureTextEntry(isSecureTextEnabled : Bool, showPasswordAppearence : Bool){
        testView.isSecureTextEntry = isSecureTextEnabled
        testView.showPasswordApperanceButton = showPasswordAppearence
    }
    
    func testSecureTextEntryAppearence(){
        setSecureTextEntry(isSecureTextEnabled: false, showPasswordAppearence: false)
        XCTAssertNil(testView.rightView, "password button is drawn when isSecureTextEntry = false")
        setSecureTextEntry(isSecureTextEnabled: true, showPasswordAppearence: false)
        XCTAssertNil(testView.rightView, "rightView should be nil")
        setSecureTextEntry(isSecureTextEnabled: false, showPasswordAppearence: true)
        XCTAssertNil(testView.rightView, "rightView should be nil")
        setSecureTextEntry(isSecureTextEnabled: true, showPasswordAppearence: true)
        XCTAssertNotNil(testView.rightView, "rightView should not be nil")
    }
    
    func testImage(){
        XCTAssertNil(testView.image, "Test view has default image")
        let image = UIImage()
        testView.image = image
        let testImage1 = UIImagePNGRepresentation(testView.image!)
        let testImage2 = UIImagePNGRepresentation(image.withRenderingMode(.alwaysTemplate))
        XCTAssertEqual(testImage1, testImage2)
        
        let image2 = UIImage()
        testView.image = image2
        let testImage3 = UIImagePNGRepresentation(testView.image!)
        let testImage4 = UIImagePNGRepresentation(image2.withRenderingMode(.alwaysTemplate))
        XCTAssertEqual(testImage3, testImage4)
    }
    
    func testDefaultColor(){
        XCTAssertEqual(testView.defaultColor, UIColor.black)
        XCTAssertEqual(testView.imageView.tintColor, UIColor.black)
        XCTAssertEqual(testView.passwordAppearanceButton?.tintColor, UIColor.black)
        
        let color = UIColor.green
        testView.defaultColor = color
        
        XCTAssertEqual(testView.defaultColor, color)
        XCTAssertEqual(testView.imageView.tintColor, color)
        XCTAssertEqual(testView.passwordAppearanceButton?.tintColor, color)
    }
    
    func testPlaceHolder(){
        testView.placeholder = "Testing Placeholder"
        
        let defaultAttributedPlaceholder = testView.attributedPlaceholder
        let currentFont = defaultAttributedPlaceholder?.attribute(NSAttributedStringKey.font, at: 0, effectiveRange: nil) as! UIFont
        XCTAssertEqual(currentFont, UIFont.systemFont(ofSize: 17))
        
        testView.placeholderColor = UIColor.red
        let newAttributedPlaceholder = testView.attributedPlaceholder
        let textColor = newAttributedPlaceholder?.attribute(NSAttributedStringKey.foregroundColor, at: 0, effectiveRange: nil) as! UIColor
        XCTAssertEqual(UIColor.red, textColor)
    }
    
    func testSeperatorLine(){
        XCTAssertEqual(testView.seperatorLineView.backgroundColor, UIColor.black)
        testView.seperatorLineColor = UIColor.green
        XCTAssertEqual(testView.seperatorLineView.backgroundColor, UIColor.green)
    }
    
    func testHandlingErrors(){
        testView.errorBorderWidth = 7
        testView.borderWidth = 3

        testView.handleError(isValid: false)
        XCTAssertEqual(testView.seperatorLineView.backgroundColor, UIColor.red)
        XCTAssertEqual(testView.imageView.tintColor, UIColor.red)
        XCTAssertEqual(testView.layer.borderColor, UIColor.red.cgColor)
        XCTAssertEqual(testView.layer.borderWidth, 7.0)
        
        testView.handleError(isValid: true)
        XCTAssertEqual(testView.seperatorLineView.backgroundColor, UIColor.black)
        XCTAssertEqual(testView.imageView.tintColor, UIColor.black)
        XCTAssertEqual(testView.layer.borderColor, UIColor.black.cgColor)
        XCTAssertEqual(testView.layer.borderWidth, 3.0)
    }
}



