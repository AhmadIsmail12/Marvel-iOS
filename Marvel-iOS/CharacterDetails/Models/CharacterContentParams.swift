//
//  CharacterContentParams.swift
//  Marvel-iOS
//
//  Created by Ahmad Ismail on 17/09/2023.
//

import Foundation

public struct CharacterContentParams: Encodable {
    private enum CodingKeys: String, CodingKey {
        case limit
    }
    // Any Extra Params Should be Here
    var limit: Int?
}
