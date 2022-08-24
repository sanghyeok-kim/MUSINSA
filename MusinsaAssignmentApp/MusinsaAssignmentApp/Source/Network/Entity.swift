//
//  Entity.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/15.
//

import Foundation

struct Entity: Decodable {
    let data: [SectionData]
}

extension Entity {
    struct SectionData: Decodable {
        let contents: Contents
        let header: Header?
        let footer: Footer?
    }
}

struct Contents: Decodable {
    let type: ContentsType
    let banners: [Banner]?
    let products: [Product]?
    let styles: [Style]?
    
    enum CodingKeys: String, CodingKey {
        case type, banners
        case products = "goods"
        case styles
    }
}

extension Contents {
    enum ContentsType: String, Decodable {
        case banner = "BANNER"
        case grid = "GRID"
        case scroll = "SCROLL"
        case style = "STYLE"
    }
}

struct Banner: Decodable {
    let linkURL: String
    let thumbnailURL: String
    let title: String
    let description: String
    let keyword: String
}

struct Product: Decodable {
    let linkURL: String
    let thumbnailURL: String
    let brandName: BrandName
    let price: Int
    let saleRate: Int
    let hasCoupon: Bool
}

enum BrandName: String, Decodable {
    case 디스커버리익스페디션 = "디스커버리 익스페디션"
    case 아스트랄프로젝션 = "아스트랄 프로젝션"
    case 텐블레이드 = "텐블레이드"
}

struct Style: Decodable {
    let linkURL: String
    let thumbnailURL: String
}

struct Footer: Decodable {
    let type: String
    let title: String
    let iconURL: String?
}

struct Header: Decodable {
    let title: String
    let iconURL: String?
    let linkURL: String?
}
