//
//  RatingControl.swift
//  MealTracker
//
//  Created by Yang Yongli on 6/21/16.
//  Copyright © 2016 Yang Yongli. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    // MARK: Properties
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    var ratingButtons = [UIButton]()
    let spacing = 5
    let starCount = 5
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let filledStarImage = UIImage(named: "filledStar")
        let emptyStarImage = UIImage(named: "emptyStar")
        
        //Create 5 button
        for _ in 0..<starCount {
            let button = UIButton()
            button.setImage(emptyStarImage, forState: .Normal)
            button.setImage(filledStarImage, forState: .Selected)
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
            
            button.adjustsImageWhenHighlighted = false
            
            //button.backgroundColor = UIColor.redColor()
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(_:)), forControlEvents: .TouchDown)
            
            ratingButtons += [button]
            addSubview(button)
        }
    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize * starCount) + (spacing * (starCount - 1))
        
        return CGSize(width: width, height: buttonSize)
    }
    
    override func layoutSubviews() {
        // Set the button's width and height to a square the size of the frame's height.
        let buttonSize = Int(frame.size.height)
        
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        // Offset each button's origin by the length of the button plus spacing.
        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (44 + spacing))
            button.frame = buttonFrame
        }
        
        updateButtonSelectionStates()
    }
    
    
    // MARK: Button Action
    func ratingButtonTapped(button: UIButton) {
        //print("Button pressed 👍")
        rating = ratingButtons.indexOf(button)! + 1
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerate() {
            // If the index of a button is less than the rating, that button should be selected.
            button.selected = index < rating
        }
    }
    

}
