//
//  LoginModel.swift
//  InspectionApp
//
//  Created by Keyur on 11/06/24.
//

import Foundation

enum Login {
    struct Request: Encodable {
        var email: String
        var password: String
    }
}
