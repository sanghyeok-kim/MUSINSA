//
//  NetworkContainer.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/15.
//

import Foundation

final class NetworkContainer {
    static var shared = NetworkContainer()
    
    private init() { }
    
    private(set) lazy var mainRepository: MainRepositoryProtocol = MainRepository()
}
