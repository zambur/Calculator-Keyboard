//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Zach Ambur on 3/2/16.
//  Copyright © 2016 Zach Ambur. All rights reserved.
//

import UIKit

enum Operation {
    case Addition
    case Multiplication
    case Subtraction
    case Division
    case Solution
    case None
}

public extension UIView {
    
    /**
     Fade in a view with a duration
     
     - parameter duration: custom animation duration
     */
    func fadeIn(duration duration: NSTimeInterval = 0.5) {
        UIView.animateWithDuration(duration, animations: {
            self.alpha = 1.0
        })
    }
    
    /**
     Fade out a view with a duration
     
     - parameter duration: custom animation duration
     */
    func fadeOut(duration duration: NSTimeInterval = 1.0) {
        UIView.animateWithDuration(duration, animations: {
            self.alpha = 0.0
        })
    }
}

class KeyboardViewController: UIInputViewController {
    
    // Image for clear button
    var clearButtonView: UIImageView!
    var shadedButtonView: UIImageView!
    var zeroShadedButtonView: UIImageView!
    
    // Right Column Buttons
    var submit: UIButton!
    var plusOp: UIButton!
    var subOp: UIButton!
    var mulOp: UIButton!
    var divOp: UIButton!
    
    // Left Column Buttons
    var clear: UIButton!
    var negative: UIButton!
    var percent: UIButton!
    var enter: UIButton!
    var nextKeyboard: UIButton!
    
    // Number Pad Buttons
    var num0: UIButton!
    var num1: UIButton!
    var num2: UIButton!
    var num3: UIButton!
    var num4: UIButton!
    var num5: UIButton!
    var num6: UIButton!
    var num7: UIButton!
    var num8: UIButton!
    var num9: UIButton!
    var dot: UIButton!
    
    // Button size constraints
    let buttonWidth = CGFloat(74)
    let buttonHeight = CGFloat(51)
    let grid = CGFloat(1)
    var heightConstraint: NSLayoutConstraint?
    
    // Calculation variables
    var updateDisplay = false
    var clearOutput = true
    var calcPercent = ""
    var equation: UILabel = UILabel()
    var output: UILabel = UILabel()
    var savedValue = 0.0
    var nextOperation = Operation.None
    
    // Adds the buttons to the number pad of the keyboard
    func addNumButtons() {
        num0 = UIButton(type: .System)
        num0.setTitle("0", forState: .Normal)
        num0.setTitleColor(UIColor.clearColor(), forState: .Normal)
        num0.backgroundColor = UIColor.clearColor()
        num0.frame = CGRect(x: 0, y: 0, width: 74, height: 50)
        num0.translatesAutoresizingMaskIntoConstraints = false
        
        num0.addTarget(self, action: Selector("buttonPressed:"), forControlEvents: .TouchDown)
        num0.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpInside)
        num0.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpOutside)
        self.view.addSubview(num0)
        
        let num0Horizontal = num0.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: buttonWidth + grid)
        let num0Vertical = num0.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: 0)
        let num0Width = num0.widthAnchor.constraintEqualToAnchor(nil, constant: buttonWidth*2 + grid)
        let num0Height = num0.heightAnchor.constraintEqualToAnchor(nil, constant: buttonHeight)
        NSLayoutConstraint.activateConstraints([num0Horizontal, num0Vertical, num0Width, num0Height])
        
        num1 = UIButton(type: .System)
        num1.setTitle("1", forState: .Normal)
        num1.setTitleColor(UIColor.clearColor(), forState: .Normal)
        num1.backgroundColor = UIColor.clearColor()
        num1.translatesAutoresizingMaskIntoConstraints = false
        
        num1.addTarget(self, action: Selector("buttonPressed:"), forControlEvents: .TouchDown)
        num1.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpInside)
        num1.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpOutside)
        self.view.addSubview(num1)
        
        let num1Horizontal = num1.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: buttonWidth + grid)
        let num1Vertical = num1.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -buttonHeight - grid)
        let num1Width = num1.widthAnchor.constraintEqualToAnchor(nil, constant: buttonWidth)
        let num1Height = num1.heightAnchor.constraintEqualToAnchor(nil, constant: buttonHeight)
        NSLayoutConstraint.activateConstraints([num1Horizontal, num1Vertical, num1Width, num1Height])
        
        num2 = UIButton(type: .System)
        num2.setTitle("2", forState: .Normal)
        num2.setTitleColor(UIColor.clearColor(), forState: .Normal)
        num2.backgroundColor = UIColor.clearColor()
        num2.translatesAutoresizingMaskIntoConstraints = false
        
        num2.addTarget(self, action: Selector("buttonPressed:"), forControlEvents: .TouchDown)
        num2.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpInside)
        num2.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpOutside)
        self.view.addSubview(num2)
        
        let num2Horizontal = num2.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: (buttonWidth+grid)*2)
        let num2Vertical = num2.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -buttonHeight - grid)
        let num2Width = num2.widthAnchor.constraintEqualToAnchor(nil, constant: buttonWidth)
        let num2Height = num2.heightAnchor.constraintEqualToAnchor(nil, constant: buttonHeight)
        NSLayoutConstraint.activateConstraints([num2Horizontal, num2Vertical, num2Width, num2Height])
        
        num3 = UIButton(type: .System)
        num3.setTitle("3", forState: .Normal)
        num3.setTitleColor(UIColor.clearColor(), forState: .Normal)
        num3.backgroundColor = UIColor.clearColor()
        num3.translatesAutoresizingMaskIntoConstraints = false
        
        num3.addTarget(self, action: Selector("buttonPressed:"), forControlEvents: .TouchDown)
        num3.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpInside)
        num3.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpOutside)
        self.view.addSubview(num3)
        
        let num3Horizontal = num3.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: (buttonWidth+grid)*3)
        let num3Vertical = num3.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -buttonHeight - grid)
        let num3Width = num3.widthAnchor.constraintEqualToAnchor(nil, constant: buttonWidth)
        let num3Height = num3.heightAnchor.constraintEqualToAnchor(nil, constant: buttonHeight)
        NSLayoutConstraint.activateConstraints([num3Horizontal, num3Vertical, num3Width, num3Height])
        
        num4 = UIButton(type: .System)
        num4.setTitle("4", forState: .Normal)
        num4.setTitleColor(UIColor.clearColor(), forState: .Normal)
        num4.backgroundColor = UIColor.clearColor()
        num4.translatesAutoresizingMaskIntoConstraints = false
        
        num4.addTarget(self, action: Selector("buttonPressed:"), forControlEvents: .TouchDown)
        num4.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpInside)
        num4.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpOutside)
        self.view.addSubview(num4)
        
        let num4Horizontal = num4.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: buttonWidth+grid)
        let num4Vertical = num4.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -(buttonHeight+grid)*2)
        let num4Width = num4.widthAnchor.constraintEqualToAnchor(nil, constant: buttonWidth)
        let num4Height = num4.heightAnchor.constraintEqualToAnchor(nil, constant: buttonHeight)
        NSLayoutConstraint.activateConstraints([num4Horizontal, num4Vertical, num4Width, num4Height])
        
        num5 = UIButton(type: .System)
        num5.setTitle("5", forState: .Normal)
        num5.setTitleColor(UIColor.clearColor(), forState: .Normal)
        num5.backgroundColor = UIColor.clearColor()
        num5.translatesAutoresizingMaskIntoConstraints = false
        
        num5.addTarget(self, action: Selector("buttonPressed:"), forControlEvents: .TouchDown)
        num5.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpInside)
        num5.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpOutside)
        self.view.addSubview(num5)
        
        let num5Horizontal = num5.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: (buttonWidth+grid)*2)
        let num5Vertical = num5.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -(buttonHeight+grid)*2)
        let num5Width = num5.widthAnchor.constraintEqualToAnchor(nil, constant: buttonWidth)
        let num5Height = num5.heightAnchor.constraintEqualToAnchor(nil, constant: buttonHeight)
        NSLayoutConstraint.activateConstraints([num5Horizontal, num5Vertical, num5Width, num5Height])
        
        num6 = UIButton(type: .System)
        num6.setTitle("6", forState: .Normal)
        num6.setTitleColor(UIColor.clearColor(), forState: .Normal)
        num6.backgroundColor = UIColor.clearColor()
        num6.translatesAutoresizingMaskIntoConstraints = false
        
        num6.addTarget(self, action: Selector("buttonPressed:"), forControlEvents: .TouchDown)
        num6.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpInside)
        num6.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpOutside)
        self.view.addSubview(num6)
        
        let num6Horizontal = num6.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: (buttonWidth+grid)*3)
        let num6Vertical = num6.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -(buttonHeight+grid)*2)
        let num6Width = num6.widthAnchor.constraintEqualToAnchor(nil, constant: buttonWidth)
        let num6Height = num6.heightAnchor.constraintEqualToAnchor(nil, constant: buttonHeight)
        NSLayoutConstraint.activateConstraints([num6Horizontal, num6Vertical, num6Width, num6Height])
        
        num7 = UIButton(type: .System)
        num7.setTitle("7", forState: .Normal)
        num7.setTitleColor(UIColor.clearColor(), forState: .Normal)
        num7.backgroundColor = UIColor.clearColor()
        num7.translatesAutoresizingMaskIntoConstraints = false
        
        num7.addTarget(self, action: Selector("buttonPressed:"), forControlEvents: .TouchDown)
        num7.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpInside)
        num7.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpOutside)
        self.view.addSubview(num7)
        
        let num7Horizontal = num7.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: buttonWidth+grid)
        let num7Vertical = num7.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -(buttonHeight+grid)*3)
        let num7Width = num7.widthAnchor.constraintEqualToAnchor(nil, constant: buttonWidth)
        let num7Height = num7.heightAnchor.constraintEqualToAnchor(nil, constant: buttonHeight)
        NSLayoutConstraint.activateConstraints([num7Horizontal, num7Vertical, num7Width, num7Height])
        
        num8 = UIButton(type: .System)
        num8.setTitle("8", forState: .Normal)
        num8.setTitleColor(UIColor.clearColor(), forState: .Normal)
        num8.backgroundColor = UIColor.clearColor()
        num8.translatesAutoresizingMaskIntoConstraints = false
        
        num8.addTarget(self, action: Selector("buttonPressed:"), forControlEvents: .TouchDown)
        num8.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpInside)
        num8.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpOutside)
        self.view.addSubview(num8)
        
        let num8Horizontal = num8.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: (buttonWidth+grid)*2)
        let num8Vertical = num8.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -(buttonHeight+grid)*3)
        let num8Width = num8.widthAnchor.constraintEqualToAnchor(nil, constant: buttonWidth)
        let num8Height = num8.heightAnchor.constraintEqualToAnchor(nil, constant: buttonHeight)
        NSLayoutConstraint.activateConstraints([num8Horizontal, num8Vertical, num8Width, num8Height])
        
        num9 = UIButton(type: .System)
        num9.setTitle("9", forState: .Normal)
        num9.setTitleColor(UIColor.clearColor(), forState: .Normal)
        num9.backgroundColor = UIColor.clearColor()
        num9.translatesAutoresizingMaskIntoConstraints = false
        
        num9.addTarget(self, action: Selector("buttonPressed:"), forControlEvents: .TouchDown)
        num9.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpInside)
        num9.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpOutside)
        self.view.addSubview(num9)
        
        let num9Horizontal = num9.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: (buttonWidth+grid)*3)
        let num9Vertical = num9.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -(buttonHeight+grid)*3)
        let num9Width = num9.widthAnchor.constraintEqualToAnchor(nil, constant: buttonWidth)
        let num9Height = num9.heightAnchor.constraintEqualToAnchor(nil, constant: buttonHeight)
        NSLayoutConstraint.activateConstraints([num9Horizontal, num9Vertical, num9Width, num9Height])
        
        dot = UIButton(type: .System)
        dot.setTitle(".", forState: .Normal)
        dot.setTitleColor(UIColor.clearColor(), forState: .Normal)
        dot.backgroundColor = UIColor.clearColor()
        dot.translatesAutoresizingMaskIntoConstraints = false
        
        dot.addTarget(self, action: Selector("buttonPressed:"), forControlEvents: .TouchUpInside)
        dot.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpInside)
        dot.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpOutside)
        self.view.addSubview(dot)
        
        let dotHorizontal = dot.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: (buttonWidth+grid)*3)
        let dotVertical = dot.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: 0)
        let dotWidth = dot.widthAnchor.constraintEqualToAnchor(nil, constant: buttonWidth)
        let dotHeight = dot.heightAnchor.constraintEqualToAnchor(nil, constant: buttonHeight)
        NSLayoutConstraint.activateConstraints([dotHorizontal, dotVertical, dotWidth, dotHeight])
    }
    
    // Adds the buttons of the right column to the keyboard
    func addRightColButtons() {
        submit = UIButton(type: .System)
        submit.setTitle("submit", forState: .Normal)
        submit.setTitleColor(UIColor.clearColor(), forState: .Normal)
        submit.backgroundColor = UIColor.clearColor()
        submit.translatesAutoresizingMaskIntoConstraints = false
        
        submit.addTarget(self, action: Selector("buttonPressed:"), forControlEvents: .TouchDown)
        submit.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpInside)
        submit.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpOutside)
        self.view.addSubview(submit)
        
        let submitHorizontal = submit.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: (buttonWidth+grid)*4)
        let submitVertical = submit.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -(buttonHeight+grid)*4)
        let submitWidth = submit.widthAnchor.constraintEqualToAnchor(nil, constant: buttonWidth)
        let submitHeight = submit.heightAnchor.constraintEqualToAnchor(nil, constant: buttonHeight + 3)
        NSLayoutConstraint.activateConstraints([submitHorizontal, submitVertical, submitWidth, submitHeight])
        
        plusOp = UIButton(type: .System)
        plusOp.setTitle("+", forState: .Normal)
        plusOp.setTitleColor(UIColor.clearColor(), forState: .Normal)
        plusOp.backgroundColor = UIColor.clearColor()
        plusOp.translatesAutoresizingMaskIntoConstraints = false
        
        plusOp.addTarget(self, action: Selector("buttonPressed:"), forControlEvents: .TouchDown)
        plusOp.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpInside)
        plusOp.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpOutside)
        self.view.addSubview(plusOp)
        
        let plusOpHorizontal = plusOp.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: (buttonWidth+grid)*4)
        let plusOpVertical = plusOp.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -(buttonHeight+grid)*3)
        let plusOpWidth = plusOp.widthAnchor.constraintEqualToAnchor(nil, constant: buttonWidth)
        let plusOpHeight = plusOp.heightAnchor.constraintEqualToAnchor(nil, constant: buttonHeight)
        NSLayoutConstraint.activateConstraints([plusOpHorizontal, plusOpVertical, plusOpWidth, plusOpHeight])
        
        subOp = UIButton(type: .System)
        subOp.setTitle("-", forState: .Normal)
        subOp.setTitleColor(UIColor.clearColor(), forState: .Normal)
        subOp.backgroundColor = UIColor.clearColor()
        subOp.translatesAutoresizingMaskIntoConstraints = false
        
        subOp.addTarget(self, action: Selector("buttonPressed:"), forControlEvents: .TouchDown)
        subOp.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpInside)
        subOp.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpOutside)
        self.view.addSubview(subOp)
        
        let subOpHorizontal = subOp.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: (buttonWidth+grid)*4)
        let subOpVertical = subOp.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -(buttonHeight+grid)*2)
        let subOpWidth = subOp.widthAnchor.constraintEqualToAnchor(nil, constant: buttonWidth)
        let subOpHeight = subOp.heightAnchor.constraintEqualToAnchor(nil, constant: buttonHeight)
        NSLayoutConstraint.activateConstraints([subOpHorizontal, subOpVertical, subOpWidth, subOpHeight])
        
        mulOp = UIButton(type: .System)
        mulOp.setTitle("*", forState: .Normal)
        mulOp.setTitleColor(UIColor.clearColor(), forState: .Normal)
        mulOp.backgroundColor = UIColor.clearColor()
        mulOp.translatesAutoresizingMaskIntoConstraints = false
        
        mulOp.addTarget(self, action: Selector("buttonPressed:"), forControlEvents: .TouchDown)
        mulOp.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpInside)
        mulOp.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpOutside)
        self.view.addSubview(mulOp)
        
        let mulOpHorizontal = mulOp.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: (buttonWidth+grid)*4)
        let mulOpVertical = mulOp.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -(buttonHeight+grid))
        let mulOpWidth = mulOp.widthAnchor.constraintEqualToAnchor(nil, constant: buttonWidth)
        let mulOpHeight = mulOp.heightAnchor.constraintEqualToAnchor(nil, constant: buttonHeight)
        NSLayoutConstraint.activateConstraints([mulOpHorizontal, mulOpVertical, mulOpWidth, mulOpHeight])
        
        divOp = UIButton(type: .System)
        divOp.setTitle("/", forState: .Normal)
        divOp.setTitleColor(UIColor.clearColor(), forState: .Normal)
        divOp.backgroundColor = UIColor.clearColor()
        divOp.translatesAutoresizingMaskIntoConstraints = false
        
        divOp.addTarget(self, action: Selector("buttonPressed:"), forControlEvents: .TouchDown)
        divOp.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpInside)
        divOp.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpOutside)
        self.view.addSubview(divOp)
        
        let divOpHorizontal = divOp.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: (buttonWidth+grid)*4)
        let divOpVertical = divOp.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: 0)
        let divOpWidth = divOp.widthAnchor.constraintEqualToAnchor(nil, constant: buttonWidth)
        let divOpHeight = divOp.heightAnchor.constraintEqualToAnchor(nil, constant: buttonHeight)
        NSLayoutConstraint.activateConstraints([divOpHorizontal, divOpVertical, divOpWidth, divOpHeight])
    }
    
    // Adds the buttons of the left column to the keyboard
    func addLeftColButton() {
        clear = UIButton(type: .System)
        clear.setTitle("AC", forState: .Normal)
        clear.setTitleColor(UIColor.clearColor(), forState: .Normal)
        clear.backgroundColor = UIColor.clearColor()
        clear.translatesAutoresizingMaskIntoConstraints = false
        
        clear.addTarget(self, action: Selector("buttonPressed:"), forControlEvents: .TouchDown)
        clear.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpInside)
        clear.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpOutside)
        self.view.addSubview(clear)
        
        let clearHorizontal = clear.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 0)
        let clearVertical = clear.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -(buttonHeight+grid)*4)
        let clearWidth = clear.widthAnchor.constraintEqualToAnchor(nil, constant: buttonWidth)
        let clearHeight = clear.heightAnchor.constraintEqualToAnchor(nil, constant: buttonHeight + 3)
        NSLayoutConstraint.activateConstraints([clearHorizontal, clearVertical, clearWidth, clearHeight])
        
        percent = UIButton(type: .System)
        percent.setTitle("%", forState: .Normal)
        percent.setTitleColor(UIColor.clearColor(), forState: .Normal)
        percent.backgroundColor = UIColor.clearColor()
        percent.translatesAutoresizingMaskIntoConstraints = false
        
        percent.addTarget(self, action: Selector("buttonPressed:"), forControlEvents: .TouchDown)
        percent.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpInside)
        percent.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpOutside)
        self.view.addSubview(percent)
        
        let percentHorizontal = percent.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 0)
        let percentVertical = percent.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -(buttonHeight+grid)*3)
        let percentWidth = percent.widthAnchor.constraintEqualToAnchor(nil, constant: buttonWidth)
        let percentHeight = percent.heightAnchor.constraintEqualToAnchor(nil, constant: buttonHeight)
        NSLayoutConstraint.activateConstraints([percentHorizontal, percentVertical, percentWidth, percentHeight])
        
        negative = UIButton(type: .System)
        negative.setTitle("+/-", forState: .Normal)
        negative.setTitleColor(UIColor.clearColor(), forState: .Normal)
        negative.backgroundColor = UIColor.clearColor()
        negative.translatesAutoresizingMaskIntoConstraints = false
        
        negative.addTarget(self, action: Selector("buttonPressed:"), forControlEvents: .TouchDown)
        negative.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpInside)
        negative.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpOutside)
        self.view.addSubview(negative)
        
        let negativeHorizontal = negative.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 0)
        let negativeVertical = negative.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -(buttonHeight+grid)*2)
        let negativeWidth = negative.widthAnchor.constraintEqualToAnchor(nil, constant: buttonWidth)
        let negativeHeight = negative.heightAnchor.constraintEqualToAnchor(nil, constant: buttonHeight)
        NSLayoutConstraint.activateConstraints([negativeHorizontal, negativeVertical, negativeWidth, negativeHeight])
        
        enter = UIButton(type: .System)
        enter.setTitle("=", forState: .Normal)
        enter.setTitleColor(UIColor.clearColor(), forState: .Normal)
        enter.backgroundColor = UIColor.clearColor()
        enter.translatesAutoresizingMaskIntoConstraints = false
        
        enter.addTarget(self, action: Selector("buttonPressed:"), forControlEvents: .TouchDown)
        enter.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpInside)
        enter.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpOutside)
        self.view.addSubview(enter)
        
        let enterHorizontal = enter.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 0)
        let enterVertical = enter.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -(buttonHeight+grid))
        let enterWidth = enter.widthAnchor.constraintEqualToAnchor(nil, constant: buttonWidth)
        let enterHeight = enter.heightAnchor.constraintEqualToAnchor(nil, constant: buttonHeight)
        NSLayoutConstraint.activateConstraints([enterHorizontal, enterVertical, enterWidth, enterHeight])
        
        nextKeyboard = UIButton(type: .System)
        nextKeyboard.setTitle("Next", forState: .Normal)
        nextKeyboard.setTitleColor(UIColor.clearColor(), forState: .Normal)
        nextKeyboard.backgroundColor = UIColor.clearColor()
        nextKeyboard.translatesAutoresizingMaskIntoConstraints = false
        
        nextKeyboard.addTarget(self, action: Selector("buttonPressed:"), forControlEvents: .TouchDown)
        nextKeyboard.addTarget(self, action: Selector("buttonReleased:"), forControlEvents: .TouchUpInside)
        nextKeyboard.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        nextKeyboard.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpOutside)
        self.view.addSubview(nextKeyboard)
        
        let nextKeyboardHorizontal = nextKeyboard.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 0)
        let nextKeyboardVertical = nextKeyboard.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: 0)
        let nextKeyboardWidth = nextKeyboard.widthAnchor.constraintEqualToAnchor(nil, constant: buttonWidth)
        let nextKeyboardHeight = nextKeyboard.heightAnchor.constraintEqualToAnchor(nil, constant: buttonHeight)
        NSLayoutConstraint.activateConstraints([nextKeyboardHorizontal, nextKeyboardVertical, nextKeyboardWidth, nextKeyboardHeight])
        
        equation.frame = CGRectMake(buttonWidth, 0, 220, 20)
        equation.textColor = UIColor.lightGrayColor()
        equation.font = output.font.fontWithSize(15)
        equation.textAlignment = NSTextAlignment.Right
        equation.text = ""
        self.view.addSubview(equation)
        
        output.frame = CGRectMake(buttonWidth, 0, 220, 69)
        output.textColor = UIColor.blackColor()
        output.font = output.font.fontWithSize(31)
        output.textAlignment = NSTextAlignment.Right
        output.text = "0"
        self.view.addSubview(output)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Displaying the main background and layout of the keyboard
        let keyboardImage = "Calculator Keyboard.png"
        let keyboard = UIImage(named: keyboardImage)
        let keyboardView = UIImageView(image: keyboard!)
        keyboardView.frame = CGRect(x: 0, y: 0, width: 375, height: 258)
        self.view.addSubview(keyboardView)
        
        // Displaying the clear button, but is hidden at first load
        let clearButtonImage = "Clear Button.png"
        let clearButton = UIImage(named: clearButtonImage)
        clearButtonView = UIImageView(image: clearButton!)
        clearButtonView.frame = CGRect(x: 0, y: 0, width: 74, height: 50)
        self.view.addSubview(clearButtonView)
        clearButtonView.hidden = true
        
        let shadedButtonImage = "ShadedButton.png"
        let shadedButton = UIImage(named: shadedButtonImage)
        shadedButtonView = UIImageView(image: shadedButton!)
        shadedButtonView.alpha = 0
        self.view.addSubview(shadedButtonView)
        
        let zeroShadedButtonImage = "ZeroShadedButton.png"
        let zeroShadedButton = UIImage(named: zeroShadedButtonImage)
        zeroShadedButtonView = UIImageView(image: zeroShadedButton!)
        zeroShadedButtonView.alpha = 0
        self.view.addSubview(zeroShadedButtonView)
        
        // Adding all keyboard buttons
        addNumButtons()
        addLeftColButton()
        addRightColButtons()
    }
    
    // Adjusting the height of the keyboard to make it larger than normal iOS 9 keyboard hight of 216 px
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.heightConstraint = NSLayoutConstraint(item:self.inputView!, attribute:.Height, relatedBy:.Equal, toItem:nil, attribute:.NotAnAttribute, multiplier:0, constant:0)
        self.heightConstraint!.priority = 999
        self.heightConstraint!.active = true
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        guard self.heightConstraint != nil && self.view.frame.size.width != 0 && self.view.frame.size.height != 0 else { return }
        
        // Height of 258 for the iPhone 6/6s which is same height as default keyboard plus suggested text window
        let portraitHeight: CGFloat = 258
        let landscapeHeight: CGFloat = 200
        let screenSize = UIScreen.mainScreen().bounds.size
        
        let newHeight = screenSize.width > screenSize.height ? landscapeHeight : portraitHeight
        
        if (self.heightConstraint!.constant != newHeight) {
            self.heightConstraint!.constant = newHeight
        }
    }
    
    func buttonPressed(button: UIButton!) {
        if let title = button.titleLabel?.text {
            if title == "0" {
                zeroShadedButtonView.frame = button.frame
                zeroShadedButtonView.fadeIn()
            } else {
                shadedButtonView.frame = button.frame
                shadedButtonView.fadeIn()
            }
        }
    }
    
    func buttonReleased(button: UIButton!) {
        if let title = button.titleLabel?.text {
            if title == "0" {
                zeroShadedButtonView.fadeOut()
            } else {
                shadedButtonView.fadeOut()
            }
            switch title {
            case "AC":
                clearDisplay()
            case "%":
                calculatePercent()
            case "+/-":
                negateNumber()
            case "=", "+", "-", "*", "/":
                operatorPressed(button)
            case "submit":
                submitPressed()
            case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ".":
                numberPressed(button)
            default: break
            }
        }
    }
    
    // Clears display when clear button is pressed
    func clearDisplay() {
        // When the AllClear ("AC") button is displayed and pressed, clear all contexts of the keyboard to original startup status
        if clearButtonView.hidden {
            equation.text = ""
            calcPercent = ""
            output.text = "0"
            clearOutput = true
            savedValue = 0.0
            nextOperation = Operation.None
        }
        // When just the clear ("C") button is displayed and pressed, only clear the contents in the user input box. Meaning it will save
        // the equation being processed and only erase the current number. Will then change button to "AC"
        else {
            if nextOperation == Operation.Solution {
                equation.text = ""
            }
            clearButtonView.hidden = true
            output.text = "0"
            clearOutput = true
        }
    }
    
    // When +/- button is pressed it will check if the current number is positive or negative and make it the opposite
    func negateNumber() {
        updateDisplay = true
        let string = output.text
        let index = string!.startIndex.advancedBy(1)
        let subStr = string?.substringToIndex(index)
        if  subStr == "-" {
            output.text = string?.substringFromIndex(index)
        } else {
            output.text = "-\(output.text!)"
        }
    }
    
    // When % button is pressed it will calculate the percent of the current number based on if it is at the begining of an equation (out of 100)
    // or if it follows a number then it will be the percent of the previous number
    func calculatePercent() {
        updateDisplay = true
        calcPercent = output.text!
        let percent = (output.text! as NSString).doubleValue / 100
        // Display 0 instead of 0.0
        if percent == 0 {
            output.text = "\(Int(percent))"
        }
        // If there is a previous number entered, add or subtract the percent of the previous number
        else if nextOperation == Operation.Addition || nextOperation == Operation.Subtraction {
            if floor(savedValue*percent) == savedValue*percent {
                // Remove the '.0' at end of double
                output.text = "\(Int(savedValue*percent))"
            } else {
                output.text = "\(savedValue*percent)"
            }
        } else {
            if percent == floor(percent) {
                // Remove the '.0' at end of double
                output.text = "\(Int(percent))"
            } else {
                output.text = "\(percent)"
            }
        }
        clearOutput = true
    }

    // Handles number pad button presses
    func numberPressed(number: UIButton!) {
        // Change clear button from "AC" to "C"
        if clearButtonView.hidden {
            clearButtonView.hidden = false
        }
        // Clear equation output if new operation is started
        if nextOperation == Operation.Solution {
            equation.text = ""
        }
        if let numberAsString = number.titleLabel?.text {
            // Clear output if new number is started
            if clearOutput {
                output.text = ""
                clearOutput = false
            }
            // Limit number of characters to fit in screen
            if output.text!.characters.count < 11 {
                if numberAsString == "." {
                    // Make sure the user can only enter 1 decimal per number
                    if output.text!.rangeOfString(".") == nil {
                        if output.text! == "" {
                            output.text = "0."
                        } else {
                            output.text = "\(output.text!)."
                        }
                    }
                } else {
                    // Display number to output
                    let numberAsNSString = numberAsString as NSString
                    output.text = "\(output.text!)\(numberAsNSString.intValue)"
                }
            }
        }
        addCommas()
    }
    
    // Inserts commas in correct locations for display
    func addCommas() {
        if output.text != "Error" {
            // Remove all previously added commas
            output.text = output.text!.stringByReplacingOccurrencesOfString(",", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            // Save index of decimal point
            let index = output.text!.rangeOfString(".", options: NSStringCompareOptions.LiteralSearch)?.startIndex
            var decimals = ""
            // If there is a decimal point save and remove all decimal numbers
            if index != nil {
                decimals = output.text!.substringFromIndex(index!)
                output.text = output.text!.substringToIndex(index!)
            }
            // Inserts commas based on number of charters in number
            switch output.text!.characters.count {
            case 4:
                output.text!.insert(",", atIndex: output.text!.startIndex.advancedBy(1))
            case 5:
                output.text!.insert(",", atIndex: output.text!.startIndex.advancedBy(2))
            case 6:
                output.text!.insert(",", atIndex: output.text!.startIndex.advancedBy(3))
            case 7:
                output.text!.insert(",", atIndex: output.text!.startIndex.advancedBy(1))
                output.text!.insert(",", atIndex: output.text!.startIndex.advancedBy(5))
            case 8:
                output.text!.insert(",", atIndex: output.text!.startIndex.advancedBy(2))
                output.text!.insert(",", atIndex: output.text!.startIndex.advancedBy(6))
            case 9:
                output.text!.insert(",", atIndex: output.text!.startIndex.advancedBy(3))
                output.text!.insert(",", atIndex: output.text!.startIndex.advancedBy(7))
            case 10:
                output.text!.insert(",", atIndex: output.text!.startIndex.advancedBy(1))
                output.text!.insert(",", atIndex: output.text!.startIndex.advancedBy(5))
                output.text!.insert(",", atIndex: output.text!.startIndex.advancedBy(9))
            default: break
            }
            // Adds deciaml numbers back into output
            output.text = "\(output.text!)\(decimals)"
        }
    }
    
    // When operand is pressed it will save inputs and then call function to calculate the result based on the next number entered
    func operatorPressed(operation: UIButton) {
        if let op = operation.titleLabel?.text {
            if op != "=" && equation.text?.rangeOfString("=") != nil {
                equation.text = ""
            }
            // Adds input to the equation display
            switch op {
            case "+":
                if calcPercent == "" {
                    equation.text = "\(equation.text!) \(output.text!) +"
                } else {
                    equation.text = "\(equation.text!) \(calcPercent)% +"
                    calcPercent = ""
                }
            case "-":
                if calcPercent == "" {
                    equation.text = "\(equation.text!) \(output.text!) -"
                } else {
                    equation.text = "\(equation.text!) \(calcPercent)% -"
                    calcPercent = ""
                }
            case "*":
                if calcPercent == "" {
                    equation.text = "\(equation.text!) \(output.text!) x"
                } else {
                    equation.text = "\(equation.text!) \(calcPercent)% x"
                    calcPercent = ""
                }
            case "/":
                if calcPercent == "" {
                    equation.text = "\(equation.text!) \(output.text!) /"
                } else {
                    equation.text = "\(equation.text!) \(calcPercent)% /"
                    calcPercent = ""
                }
            case "=":
                if equation.text?.rangeOfString("=") == nil {
                    if calcPercent == "" {
                        equation.text = "\(equation.text!) \(output.text!) ="
                    } else {
                        equation.text = "\(equation.text!) \(calcPercent)% ="
                        calcPercent = ""
                    }
                }
            default: break
            }

            //removes all commas from input to save as a double
            output.text = output.text!.stringByReplacingOccurrencesOfString(",", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            // When it is the first number entered in an operation, no need to compute operation, save value straight to output
            if nextOperation == Operation.None {
                let inputAsDouble = (output.text! as NSString).doubleValue
                savedValue = inputAsDouble
                clearOutput = true
            } else {
                // If not the first number entered, calculate output
                computeLastOperation()
            }
            // Re-add commas back into the output
            addCommas()
            
            // Save which operand the user presses as the next operation to be computed
            switch op {
            case "+":
                nextOperation = Operation.Addition
            case "-":
                nextOperation = Operation.Subtraction
            case "*":
                nextOperation = Operation.Multiplication
            case "/":
                nextOperation = Operation.Division
            case "=":
                nextOperation = Operation.Solution
            default:
                nextOperation = Operation.None
            }
        }
    }
    
    // Transfers output display to the users iPhone at location of cursor
    func submitPressed() {
        let proxy = textDocumentProxy as UITextDocumentProxy
        
        if let output = output.text as String? {
            proxy.insertText(output)
        }
    }
    
    // Computes operations whenever an operation is pressed or equal sign is pressed. Calculates inputs based on a immediate execution calculator
    // system, by computing one operation after another right away.
    func computeLastOperation() {
        let inputAsDouble = (output.text! as NSString).doubleValue
        var answer = 0.0
            
        // apply the operation
        switch nextOperation {
        case .Addition:
            answer = savedValue + inputAsDouble
        case .Subtraction:
            answer = savedValue - inputAsDouble
        case .Multiplication:
            answer = savedValue * inputAsDouble
        case .Division:
            answer = savedValue / inputAsDouble
        case .Solution:
            answer = inputAsDouble
        default:
            answer = savedValue
        }
            
        nextOperation = Operation.None
        
        var result = "\(answer)"
        if result == "nan" {
            result = "Error"
            output.text = result
        } else {
            // if the result is an integer don't show the decimal point
            if result.hasSuffix(".0") {
                result = "\(Int(answer))"
            }
            
            // truncatingg to last five digits
            var components = result.componentsSeparatedByString(".")
            if components.count >= 2 {
                let beforePoint = components[0]
                var afterPoint = components[1]
                if afterPoint.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 5 {
                    let index: String.Index = afterPoint.startIndex.advancedBy(5)
                    afterPoint = afterPoint.substringToIndex(index)
                }
                result = beforePoint + "." + afterPoint
            }
            
            // update the display
            output.text = result
            addCommas()
            
            // save the result
            savedValue = answer
        }
        clearOutput = true
    }
}
