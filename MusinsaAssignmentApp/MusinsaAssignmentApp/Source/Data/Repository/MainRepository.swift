//
//  MainRepository.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/14.
//

import Foundation

protocol MainRepositoryProtocol {
    func requestDataFromBundle(completion: @escaping (Result<MusinsaEntity, NetworkError>) -> Void)
}

final class MainRepository: BaseRepository, MainRepositoryProtocol {
    
    func requestDataFromBundle(completion: @escaping (Result<MusinsaEntity, NetworkError>) -> Void) {
        
        guard let url = Bundle.main.url(forResource: "MockData", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        if let decodedData = Self.decode(MusinsaDTO.self, decodeTarget: data) {
            completion(.success(decodedData.toDomain()))
        } else {
            completion(.failure(.failToDecode))
        }
    }
    
    func requestData(completion: @escaping (Result<MusinsaEntity, NetworkError>) -> Void) {
        //https://meta.musinsa.com/interview/list.json
    }
}

//repository는 usecase의 요청을 위의 service를 이용해서 서버에 요청 보내기만 함
//service로부터 받은 DTO를 entity로 변환해서 usecase에게 응답해줌
//usecase의 요청이 POST일 경우, 함께 받았던 매개변수를 dto로 변환해서 service 이용
