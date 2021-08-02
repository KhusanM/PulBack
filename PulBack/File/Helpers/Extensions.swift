//
//  Extensions.swift
//  PulBack
//
//  Created by Kuziboev Siddikjon on 7/28/21.
//

import UIKit

extension UIViewController {
    
    var isSmallScreen : Bool {
        if UIScreen.main.bounds.height < 600 {
            return true
        }
        return false
    }
    
}

//MARK: - UINavigation Bar
extension UINavigationBar {
    func shouldRemoveShadow(_ value: Bool) -> Void {
        self.setValue(value, forKey: "hidesShadow")
    }
}

extension UITapGestureRecognizer{
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
         // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
         let layoutManager = NSLayoutManager()
         let textContainer = NSTextContainer(size: CGSize.zero)
         let textStorage = NSTextStorage(attributedString: label.attributedText!)

         // Configure layoutManager and textStorage
         layoutManager.addTextContainer(textContainer)
         textStorage.addLayoutManager(layoutManager)

         // Configure textContainer
         textContainer.lineFragmentPadding = 0.0
         textContainer.lineBreakMode = label.lineBreakMode
         textContainer.maximumNumberOfLines = label.numberOfLines
         let labelSize = label.bounds.size
         textContainer.size = labelSize

         // Find the tapped character location and compare it to the specified range
         let locationOfTouchInLabel = self.location(in: label)
         let textBoundingBox = layoutManager.usedRect(for: textContainer)
         //let textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                               //(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
         let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)

         //let locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
                                                         // locationOfTouchInLabel.y - textContainerOffset.y);
         let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
         let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
         return NSLocationInRange(indexOfCharacter, targetRange)
     }
}

