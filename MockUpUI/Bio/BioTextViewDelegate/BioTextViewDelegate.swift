//
//  BioTextViewDelegate.swift
//  MockUpUI
//
//  Created by Phil Martin on 19/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class BioTextViewDelegate: NSObject, UITextViewDelegate{
    
    var updateTextViewCountLabel: ((Int?)-> Void)?
    weak var parentView: UIView? = nil
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // Combine the textView text and the replacement text to
        // create the updated text string
  
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            
            textView.text = bioTextViewplaceHolder
            textView.textColor = UIColor.lightGray
            
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            updateTextViewCountLabel?(0) // send a zero here because we don't have any text other then placeholder text
        }
            
            // Else if the text view's placeholder is showing and the
            // length of the replacement string is greater than 0, set
            // the text color to black then set its text to the
            // replacement string
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
            updateTextViewCountLabel?(textView.text.count)
        }
            
            // For every other case, the text should change with the usual
            // behavior...
        else {
            updateTextViewCountLabel?(textView.text.count)
            return textView.text.count + (text.count - range.length) <= bioTextViewTextLength
        }
        // ...otherwise return false since the updates have already
        // been made
        return false
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if parentView?.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if parentView?.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
}
