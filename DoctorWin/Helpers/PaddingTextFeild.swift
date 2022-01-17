//
//  PaddingTextFeild.swift
//  DoctorWin
//
//  Created by N517325 on 04/11/21.
//

import Foundation
import UIKit

@IBDesignable
class PaddingTextFeild: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)

       override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
       }

       override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
       }

       override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
       }
}

