//
//  EnumConstant.swift
//  InspectionApp
//
//  Created by Keyur on 11/06/24.
//

import Foundation

enum APIStatusCode: Int, Codable {
    case success                    = 200
    case unauthorized               = 401
    case internalServerError        = 500
}
