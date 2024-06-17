//
//  StringExtension.swift
//  InspectionApp
//
//  Created by Amisha on 14/06/24.
//

import Foundation

extension String {
    var isValidEmail: Bool {
       let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
       let emailTest  = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
