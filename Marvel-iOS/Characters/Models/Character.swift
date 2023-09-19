//
//  Character.swift
//  Mavel-iOS
//
//  Created by Ahmad Ismail on 17/09/2023.
//

import Foundation

public struct Character : Codable {
    
    let id: Int?
    let name : String?
    let description : String?
    let thumbnail: Image?
    
    init(id: Int?,
         name : String?,
         description : String?,
         thumbnail: Image?) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
    }
}
