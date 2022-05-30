//
//  Extensions.swift
//  High Waters
//
//  Created by Marco Mascorro on 5/29/22.
//

//MARK: - Auto Layout Notes
/*
 --None Label Views--
 -When working with constraints, you always need an x-axis anchor and a y-axis anchor.
 -When working with views such as button or other kind of views that dont involved text, you always need to set a width and height property
 -MUST BE GIVEN X-AXIS, Y-AXIS, WIDTH AND HEIGHT PROPERTIES
 
 
 --Label Views--
 -When working with a label, you dont need to set width and height properties because xcode with figure that out for you.
 
 */



import UIKit


//MARK: - View Extension
//Writing this extensions on uiview, every subclass element im gonna write is gonna be tide to uiview element
extension UIView {
    
    /*
     --func anchor notes--
     -So we write this function called anchor to help us anchor our views to certain places on the screen dimensions.
     -this function takes in some optional values with the default value of nil, because we might not need them when setting up the anchor
     */
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        //this lets me setup autolayout programatically turning off auto resizing constrains
        translatesAutoresizingMaskIntoConstraints = false
        
        
        //Unwraping optionals to check if there is something in the properties that are passed in through the function.
        if let top = top {
            //if the item is unwrapped the top anchor constrain is equal to top, with the constant that is passed through the padding top which by default is set to 0
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        //Unwraping optionals to check if there is something in the properties that are passed in through the function.
        if let left = left {
            //if the item is unwrapped the left anchor constrain if equal to left, with the constant that is passed through the padding top which by default
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        //Unwraping optionals to check if there is something in the properties that are passed in through the function.
        if let bottom = bottom {
            //if the item is unwrapped the bottom anchor constrain if equal to bottom, with the constant that is passed, and the constant is made a negative
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        //Unwraping optionals to check if there is something in the properties that are passed in through the function.
        if let right = right {
            //if the item is unwrapped the right anchor constrain if equal to right, with the constant that is passed through the negative padding right which by default is nil
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        //Unwraping optionals to check if there is something in the properties that are passed in through the function.
        if let width = width {
            //if the item is unwrapped the width anchor constrain if equal to width
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        //Unwraping optionals to check if there is something in the properties that are passed in through the function.
        if let height = height {
            //if the item is unwrapped the height anchor constrain if equal to height.
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func center(inView view: UIView, yConstant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
    }
    
    func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
        }
    }
    
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat? = nil, constant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant!).isActive = true
        
        if let leftAnchor = leftAnchor, let padding = paddingLeft {
            self.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
        }
    }
    
    //Useful if i just want to set my dimensions for my view
    func setDimensions(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    //this function is useful if i want to full the entireview with another view.
    func addConstraintsToFillView(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(top: view.topAnchor, left: view.leftAnchor,
               bottom: view.bottomAnchor, right: view.rightAnchor)
    }
}

// MARK: - UIColor

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let twitterBlue = UIColor.rgb(red: 29, green: 161, blue: 242)
}






