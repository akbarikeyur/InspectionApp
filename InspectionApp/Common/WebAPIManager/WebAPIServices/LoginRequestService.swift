//
//  LoginRequestService.swift
//  InspectionApp
//
//  Created by Keyur on 11/06/24.
//

import Foundation

class LoginRequestService: BaseRequestService
{
    func login(request: Login.Request, completionHandler: @escaping (_ response: Bool?, _ errorResponse: ErrorResponseModel?)->()) {
        
        call(apiConfiguration: WebAPIRouter.login, params: request.toJSON(), responseType: Bool.self, isLoaderDisplay: true) { response, error in
            
            if let status = response {
                completionHandler(true, nil)
            }else{
                completionHandler(nil, error)
            }
        }
    }
    
    func register(request: Register.Request, completionHandler: @escaping (_ response: Bool?, _ errorResponse: ErrorResponseModel?)->()) {
        
        call(apiConfiguration: WebAPIRouter.register, params: request.toJSON(), responseType: Bool.self, isLoaderDisplay: true) { response, error in
            
            if let status = response {
                completionHandler(true, nil)
            }else{
                completionHandler(nil, error)
            }
        }
    }
}
