//
//  NetworkError.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/14.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case failToDecode
}

enum ImageNetworkError: Error {
    case errorDetected
    case invalidFileLocation
}
