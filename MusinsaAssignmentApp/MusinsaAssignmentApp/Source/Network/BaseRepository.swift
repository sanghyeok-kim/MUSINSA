//
//  BaseRepository.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/14.
//

import Foundation
import UIKit

class BaseRepository {
    static func decode<T: Decodable>(_ type: T.Type, decodeTarget data: Data?) -> T? {
        if let data = data,
              let decodedData = try? JSONDecoder().decode(type.self, from: data) {
            return decodedData
        } else {
            return nil
        }
    }
}
