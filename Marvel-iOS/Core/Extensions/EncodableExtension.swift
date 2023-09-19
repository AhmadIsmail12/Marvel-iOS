//
//  EncodableExtension.swift
//  Marvel-iOS
//
//  Created by Ahmad Ismail on 17/09/2023.
//

import Foundation

extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let josnData = try JSONSerialization.jsonObject(with: data)
        return josnData as? [String : Any]
    }
}
