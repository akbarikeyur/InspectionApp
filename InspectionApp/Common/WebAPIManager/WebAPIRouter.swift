//
//  WebAPIRouter.swift
//  InspectionApp
//
//  Created by Keyur on 11/06/24.
//

import Foundation
import Alamofire

let kBaseURL                        = "http://127.0.0.1:5001/api/"

protocol APIConfiguration {
    var baseURL: String { get }
    var url: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var encoding: ParameterEncoding { get }
}

enum WebAPIRouter: APIConfiguration {
    case register
    case login
    case startInspection
    case submitInspection
    case random_inspection
    case inspections(inspectionId: Int)
    
    var baseURL: String {
        return "\(kBaseURL)"
    }
    
    var method: HTTPMethod {
        switch self {
        case .register, .login, .submitInspection:
                return .post
            default:
                return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
            default:
                return createCommonHeader()
        }
    }

    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var url: URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.path)!
        }
    }
    
    var path: String {
        switch self {
            case .register:
                return "register"
            case .login:
                return "login"
            case .startInspection:
                return "inspections/start"
            case .submitInspection:
                return "inspections/submit"
            case .random_inspection:
                return "random_inspection"
            case .inspections(inspectionId: let inspectionId):
                return "inspections/\(inspectionId)"
        }
    }
    
}

extension WebAPIRouter {
    private struct CommonHeader {
        static var contentType                          = "Content-Type"
        static var accept                               = "Accept"
    }
    
    private func createCommonHeader() -> HTTPHeaders {

        let dict: HTTPHeaders = [
//            CommonHeader.accept: "application/json",
            CommonHeader.contentType: "application/json",
        ]
        return dict
    }
}
