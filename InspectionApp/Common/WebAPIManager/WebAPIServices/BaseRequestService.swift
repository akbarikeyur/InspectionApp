//
//  BaseRequestService.swift
//  InspectionApp
//
//  Created by Keyur on 11/06/24.
//

import Foundation
import Alamofire

class ErrorResponseModel: Codable {
    let error: String?
    
}

class AlertMessage: Identifiable {
    var id: String { title ?? ""}
    var title : String?
    var message : String?
    
    init(title: String?, message: String?) {
        self.title = title ?? kAppName
        self.message = message ?? ""
    }
}

class BaseRequestService {
    private let sessionManager = Session()
    
    private func parseApiError(data: Data?) -> ErrorResponseModel {
        if let jsonData = data, let error = decodeData(model: ErrorResponseModel.self, data: jsonData) {
            return error
        }
        return getDataModel(model: ErrorResponseModel.self, jsonData: ["status": "404", "message": "Not Found", "title": "Error"])!
    }

    private func parseErrors(data: Data?) {
        if let _ = data {
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
            }
            catch let error {
                
            }
                
        }
        //jsonData
    }
    
    func call<T:Decodable>(apiConfiguration: APIConfiguration, params: Parameters? = nil, responseType : T.Type?, isLoaderDisplay: Bool, handler: @escaping (_ response : Data?, _ errorResponse: ErrorResponseModel?)->()){
        let header = apiConfiguration.headers ?? HTTPHeaders()
        debugPrint("HEADERS: \(header)")
        debugPrint("API: \(apiConfiguration.url)")
        if params != nil {
            debugPrint("PARAMS: \(params!)")
        }
//        let header: HTTPHeaders = [HTTPHeader(name: "Content-Type", value: "application/json"), HTTPHeader(name: "Accept", value: "application/json")]
        AF.request(
            apiConfiguration.url,
            method: apiConfiguration.method,
            parameters: params,
            encoding: JSONEncoding.default,
            headers: header)
        .responseData { responseData in
            
            if let statusCode = responseData.response?.statusCode {
                if statusCode == APIStatusCode.success.rawValue {
                    if let jsonData = responseData.data {
                        handler(jsonData, nil)
                    }
                    else {
                        handler("true".data(using: .utf8), nil)
                    }
                }
                else {
                    if let jsonData = responseData.data {
                        do {
                            let result = try JSONDecoder().decode(ErrorResponseModel.self, from: jsonData)
                            debugPrint("RESPONSE: \(result)")
                            handler(nil, result)
                        }
                        catch let err {
                            print("ERROR OCCURED WHILE DECODING: \(err)")
                        }
                    }
                }
            }
        }
        
        return
        
        let requestHeader = apiConfiguration.headers ?? HTTPHeaders()
        
        debugPrint("HEADERS: \(requestHeader)")
        debugPrint("API: \(apiConfiguration.url)")
        if params != nil {
            debugPrint("PARAMS: \(params!)")
        }
        if isLoaderDisplay {
//            ActivityIndicatorManager.shared.showLoader()
        }
        self.sessionManager.request(apiConfiguration.url,
                                    method: apiConfiguration.method,
                                    parameters: params,
                                    encoding: apiConfiguration.encoding,
                                    headers: requestHeader).validate().responseData
        { responseData in
//            ActivityIndicatorManager.shared.hideLoader()
            
            if let statusCode = responseData.response?.statusCode {
                if statusCode == APIStatusCode.success.rawValue {
                    if let jsonData = responseData.data {
                        handler(jsonData, nil)
                    }
                    else {
                        handler("true".data(using: .utf8), nil)
                    }
                }
            }
//            switch responseData.result {
//            case .success(_):
//                if let jsonData = responseData.data {
//                    do {
//                        let result = try JSONDecoder().decode(T.self, from: jsonData)
//                        debugPrint("RESPONSE: \(result)")
//                        handler(result, nil)
//                    }
//                    catch let err {
//                        print("ERROR OCCURED WHILE DECODING: \(err)")
//                    }
//                }
//                break
//            case .failure(_):
//                print("API Request Error : \(self.parseApiError(data: responseData.data))")
//                handler(nil, self.parseApiError(data: responseData.data))
//                break
//            }
        }
    }
}
