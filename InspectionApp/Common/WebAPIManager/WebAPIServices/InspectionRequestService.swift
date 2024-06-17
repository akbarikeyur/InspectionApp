//
//  InspectionRequestService.swift
//  InspectionApp
//
//  Created by Keyur on 13/06/24.
//

import Foundation

class InspectionRequestService: BaseRequestService
{
    func startInspection(completionHandler: @escaping (_ response: Inspection.Response?, _ errorResponse: ErrorResponseModel?)->()) {
        
        call(apiConfiguration: WebAPIRouter.startInspection, responseType: Inspection.Response.self, isLoaderDisplay: true) { response, error in
            
            if let responseData = response {
                do {
                    let result = try JSONDecoder().decode(Inspection.Response.self, from: responseData)
                    debugPrint("RESPONSE: \(result)")
                    completionHandler(result, nil)
                }
                catch let err {
                    print("ERROR OCCURED WHILE DECODING: \(err)")
                }
            } else if let errorResponse = error {
                completionHandler(nil, errorResponse)
            }
        }
    }
    
    func submitInspection(request: Inspection.Submit, completionHandler: @escaping (_ response: Bool?, _ errorResponse: ErrorResponseModel?)->()) {
        
        call(apiConfiguration: WebAPIRouter.submitInspection, params: request.toJSON(), responseType: Bool.self, isLoaderDisplay: true) { response, error in
            
            if let responseData = response {
                do {
                    let result = try JSONDecoder().decode(Bool.self, from: responseData)
                    debugPrint("RESPONSE: \(result)")
                    completionHandler(result, nil)
                }
                catch let err {
                    print("ERROR OCCURED WHILE DECODING: \(err)")
                }
            } else if let errorResponse = error {
                completionHandler(nil, errorResponse)
            }
        }
    }
    
    func getRandomInspection(completionHandler: @escaping (_ response: Inspection.Response?, _ errorResponse: ErrorResponseModel?)->()) {
        
        call(apiConfiguration: WebAPIRouter.random_inspection, responseType: Inspection.Response.self, isLoaderDisplay: true) { response, error in
            
            if let responseData = response {
                do {
                    let result = try JSONDecoder().decode(Inspection.Response.self, from: responseData)
                    debugPrint("RESPONSE: \(result)")
                    completionHandler(result, nil)
                }
                catch let err {
                    print("ERROR OCCURED WHILE DECODING: \(err)")
                }
            } else if let errorResponse = error {
                completionHandler(nil, errorResponse)
            }
        }
    }
    
    func deleteInspection(request: Inspection.Request, completionHandler: @escaping (_ response: Bool?, _ errorResponse: ErrorResponseModel?)->()) {
        
        call(apiConfiguration: WebAPIRouter.inspections(inspectionId: request.inspectionId), params: request.toJSON(), responseType: Bool.self, isLoaderDisplay: true) { response, error in
            
            if let status = response {
                completionHandler(true, nil)
            }else{
                completionHandler(nil, error)
            }
        }
    }
    
}
