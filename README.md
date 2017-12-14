# LoginTextField

[![Version](https://img.shields.io/cocoapods/v/LoginTextField.svg?style=flat)](http://cocoapods.org/pods/LoginTextField)
[![License](https://img.shields.io/cocoapods/l/LoginTextField.svg?style=flat)](http://cocoapods.org/pods/LoginTextField)
[![Platform](https://img.shields.io/cocoapods/p/LoginTextField.svg?style=flat)](http://cocoapods.org/pods/LoginTextField)

LoginTextField is a subclass of UITextField. 

Using LoginTextField, you can easily set images to the left of the field. It has a seperator between the field's text and left image. If your field has "secure text entry" option, it automatically displays a "show/hide password" button in it.

LoginTextField's almost all subs can change its color, including the placeholder.

It has built-in support for validations. All you need to call `handleError(isValid:)` function. You can do validation easily using [Validator](https://github.com/adamwaite/Validator) by Adam Waite.

![](/READMEAssets/LoginTextField.gif)

## Features
* All variables are bound to the storyboards/.xibs via IBInspectables. 
* Built-in error showing function.
* You can change the color of all subs.
* Very tiny.

## Usage

You can initialize LoginTextField programmatically or in a storyboard/.xib.

> If you are using storyboard or .xib file, you should set `borderStyle` to `.none`. Otherwise you might experience unexpected behaviours, especially with corder radius.

If you are using storyboards/.xibs you can set all the variables using interface builder.

If you are initializing the calss programmatically, these are your todo's:


### Initialization
```swift
let field = LoginTextField.init(frame: CGRect.zero)   //set your own rect.
```

### Left Image
```swift
field.image = UIImage...
```

### Left Image and "show/hide password button" Color
```swift
field.imageColor = UIColor...
```

### Placeholder Color
```swift
field.placeholderColor = UIColor...
```

### Error Color
```swift
field.errorColor = UIColor...   //if you will use handleError(isValid:) function, you should specify an error color for validation errors. This color is used when handleError(isValid:) return false.
```

### Seperator Line Color
```swift
field.lineColor = UIColor...
```

### Corner Radius
```swift
field.cornerRadius = CGFloat...
```

### Border
```swift
field.borderWidth = CGFloat...
field.borderColor = UIColor...
````

### Handling Validation Errors
```swift
field.handleError(isValid: ....)   //this will change the left image color, the seperator line color and the border color (if border width is set > 0).
```

## Requirements
LoginTextField requires min version of `iOS10` and `Swift4`

## Installation

### CocoaPods
LoginTextField is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LoginTextField'
```


### Carthage
```ruby
github "anelad/LoginTextField"
```

## Author
Arda Oğul Üçpınar, info@ardaucpinar.com

## Contribution
Any contributions and suggestions are most welcome! Please update the README with any new features. Thanks!

## License
LoginTextField is available under the MIT license. See the LICENSE file for more info.
