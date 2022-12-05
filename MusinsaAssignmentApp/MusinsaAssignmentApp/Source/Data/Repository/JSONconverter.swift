//
//  JSONConverter.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/09/04.
//

import Foundation

struct JSONConverter<T: Codable> {
    typealias Model = T

    static func decode(data: Data) -> Model? {
        guard let json = try? JSONDecoder().decode(Model.self, from: data) else { return nil }
        return json
    }

    static func encode(model: Model) -> Data? {
        guard let data = try? JSONEncoder().encode(model) else { return nil }
        return data
    }
}
