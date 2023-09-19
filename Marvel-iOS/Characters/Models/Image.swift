//
//  Image.swift
//  Marvel-iOS
//
//  Created by Ahmad Ismail on 17/09/2023.
//

import Foundation

struct Image: Codable {
    enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }
    
    var path: String?
    var fileExtension: String?
    
    // This Func Return the thumbnail image as a URL string
    // Combination of path and extension
    func getImageUrl() -> String {
        if let path, let fileExtension {
            return path + "." + fileExtension
        }
        return ""
    }
}
