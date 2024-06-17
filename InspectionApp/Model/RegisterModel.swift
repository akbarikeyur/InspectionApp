//
//  RegisterModel.swift
//  InspectionApp
//
//  Created by Keyur on 12/06/24.
//

import Foundation

enum Register {
    struct Request: Encodable {
        var email: String
        var password: String
    }
}
