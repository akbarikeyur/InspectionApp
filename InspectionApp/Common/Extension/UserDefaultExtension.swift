//
//  UserDefaultExtension.swift
//  InspectionApp
//
//  Created by Keyur on 13/06/24.
//

import Foundation

protocol ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
}

extension UserDefaults: ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        } catch {
            throw ObjectSavableError.unableToEncode
        }
    }
    
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable {
        guard let data = data(forKey: forKey) else { throw ObjectSavableError.noValue }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw ObjectSavableError.unableToDecode
        }
    }
}

enum ObjectSavableError: String, LocalizedError {
    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"
    
    var errorDescription: String? {
        rawValue
    }
}

extension UserDefaults {
    func saveInspectionData(inspectionData: Inspection.Response) {
        do {
            try UserDefaults.standard.setObject(inspectionData, forKey: "InspectionData")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveQuestionData(questionsData: [Inspection.QuestionDisplay]) {
        do {
            try UserDefaults.standard.setObject(questionsData, forKey: "QuestionsData")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchInspectionData() -> Inspection.Response? {
        do {
            let inspection = try UserDefaults.standard.getObject(forKey: "InspectionData", castTo: Inspection.Response.self)
            return inspection
        } catch {
            debugPrint(error.localizedDescription)
        }
        return nil
    }
    
    func fetchQuestionData() -> [Inspection.QuestionDisplay] {
        do {
            let questions = try UserDefaults.standard.getObject(forKey: "QuestionsData", castTo: [Inspection.QuestionDisplay].self)
            return questions
        } catch {
            debugPrint(error.localizedDescription)
        }
        return [Inspection.QuestionDisplay]()
    }
    
    func deleteInspectionData() {
        
        UserDefaults.standard.set(nil, forKey: "InspectionData")
        UserDefaults.standard.set(nil, forKey: "QuestionsData")
        
        UserDefaults.standard.removeObject(forKey: "InspectionData")
        UserDefaults.standard.removeObject(forKey: "QuestionsData")
        
        UserDefaults.standard.synchronize()
    }
    
    func saveCompletedInspection(data: Inspection.CompletedInspection) {
        var completedInspection = fetchCompletedInspection()
        completedInspection.append(data)
        do {
            try UserDefaults.standard.setObject(completedInspection, forKey: "CompletedInspection")
            UserDefaults.standard.synchronize()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchCompletedInspection() -> [Inspection.CompletedInspection] {
        do {
            let data = try UserDefaults.standard.getObject(forKey: "CompletedInspection", castTo: [Inspection.CompletedInspection].self)
            return data
        }
        catch {
            print(error.localizedDescription)
        }
        return [Inspection.CompletedInspection]()
    }
    
    func deleteCompletedInspection() {
        
        UserDefaults.standard.set(nil, forKey: "CompletedInspection")
        UserDefaults.standard.removeObject(forKey: "CompletedInspection")
        UserDefaults.standard.synchronize()
    }
}
