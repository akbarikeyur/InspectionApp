//
//  EncodableExtension.swift
//  InspectionApp
//
//  Created by Keyur on 11/06/24.
//

import Foundation

extension Encodable {
    //MARK:-  Converting object to postable JSON
    public func toJSON(_ encoder: JSONEncoder = JSONEncoder()) -> [String: Any] {
        guard let data = try? encoder.encode(self) else { return [:] }
        guard let object = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else { return [:] }
        guard let json = object as? [String: Any] else { return [:] }
        return json
    }
}
