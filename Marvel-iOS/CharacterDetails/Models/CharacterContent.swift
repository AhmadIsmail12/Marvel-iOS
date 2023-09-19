//
//  CharacterContent.swift
//  Marvel-iOS
//
//  Created by Ahmad Ismail on 17/09/2023.
//

import Foundation

public struct CharacterContent: Codable {
    
    let id: Int?
    let title : String?
    let description : String?
    let thumbnail: Image?
    
    init(id: Int?,
         title : String?,
         description : String?,
         thumbnail: Image?) {
        self.id = id
        self.title = title
        self.description = description
        self.thumbnail = thumbnail
    }
}
