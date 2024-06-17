//
//  CommonFunction.swift
//  InspectionApp
//
//  Created by Keyur on 11/06/24.
//

import Foundation
import UIKit

// MARK: - Convert json to given model.
func getDataModel<T: Decodable>(model: T.Type, jsonData: [String:Any]) -> T? {
    do {
        let data = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
        let decodedModel = decodeData(model: model, data: data)
        return decodedModel
    }
    catch let error {
        print("error : \(error.localizedDescription)")
    }
    return nil
}

func decodeData<T: Decodable>(model: T.Type, data: Data) -> T? {
    do {
        let decodedModel = try JSONDecoder().decode(model.self, from: data)
        return decodedModel
    }
    catch let error {
        print("error : \(error.localizedDescription)")
    }
    return nil
}

func getDataModelFromJsonFile<T: Decodable>(_ file : String, model: T.Type) -> T? {
    if let filePath = Bundle.main.path(forResource: file, ofType: "json"), let data = NSData(contentsOfFile: filePath) as? Data {
        do {
            let success = decodeData(model: model, data: data)
            return success
        }
        catch {
            //Handle error
        }
    }
    return nil
}
