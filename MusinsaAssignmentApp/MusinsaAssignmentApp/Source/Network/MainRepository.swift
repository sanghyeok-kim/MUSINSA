//
//  MainRepository.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/14.
//

import Foundation

protocol MainRepositoryProtocol {
    func requestDataFromBundle(completion: @escaping (Result<Entity, NetworkError>) -> Void)
}

final class MainRepository: BaseRepository, MainRepositoryProtocol {
    func requestDataFromBundle(completion: @escaping (Result<Entity, NetworkError>) -> Void) {
        guard let url = Bundle.main.url(forResource: "MockData", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        if let decodedData = Self.decode(Entity.self, decodeTarget: data) {
            completion(.success(decodedData))
        } else {
            completion(.failure(.failToDecode))
        }
    }
    //https://meta.musinsa.com/interview/list.json
    func requestData(completion: @escaping (Result<Entity, NetworkError>) -> Void) {
        
    }
}
