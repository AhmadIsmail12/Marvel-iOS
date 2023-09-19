//
//  Response.swift
//  Mavel-iOS
//
//  Created by Ahmad Ismail on 17/09/2023.
//

import Foundation

struct Response<T: Decodable>: Decodable {
    enum CodingKeys: String, CodingKey {
        case status
        case message
        case data
    }
    let status: String?
    let message: String?
    let data: BasePaginatedResponse<T>?

    init(
        status: String? = nil,
        message: String? = nil,
        data: BasePaginatedResponse<T>? = nil
    ) {
        self.status = status
        self.message = message
        self.data = data
    }
}
