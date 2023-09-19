//
//  BasePaginatedResponse.swift
//  Mavel-iOS
//
//  Created by Ahmad Ismail on 17/09/2023.
//

import Foundation

struct BasePaginatedResponse<T: Decodable>: Decodable {
    enum CodingKeys: String, CodingKey {
        case offset
        case limit
        case total
        case count
        case results
    }
    
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [T]?

    init(offset: Int?,
         limit: Int?,
         total: Int?,
         count: Int?,
         results: [T]?) {
        self.offset = offset
        self.limit = limit
        self.total = total
        self.count = count
        self.results = results
    }
}
