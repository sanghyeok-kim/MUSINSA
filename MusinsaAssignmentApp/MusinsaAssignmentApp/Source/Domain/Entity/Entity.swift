//
//  Entity.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/08/21.
//

import Foundation

struct MusinsaEntity {
    let data: [SectionEntity]
}

struct SectionEntity {
    let contents: ContentsEntity
    let header: HeaderEntity?
    let footer: FooterEntity?
    
    var contentsType: ContentsEntity.`Type` {
        return contents.contentsType
    }
    
    var contentsItems: [ItemEntityType] {
        return contents.items
    }
    
    var contentsItemCount: Int {
        return contentsItems.count
    }
}

struct ContentsEntity {
    enum `Type` {
        case banner
        case grid
        case scroll
        case style
    }
    
    let contentsType: `Type`
    let items: [ItemEntityType]
}

protocol ItemEntityType { }

protocol Tappable {
    var linkUrl: URL? { get }
}

struct BannerEntity: ItemEntityType, Tappable {
    let linkUrl: URL?
    let thumbnailUrl: URL?
    let title: String
    let description: String
    let keyword: String
}

struct ProductEntity: ItemEntityType, Tappable {
    let linkUrl: URL?
    let thumbnailUrl: URL?
    let brandName: String
    let price: String
    let saleRate: String?
    let hasCoupon: Bool
}

struct StyleEntity: ItemEntityType, Tappable {
    let linkUrl: URL?
    let thumbnailUrl: URL?
}

struct HeaderEntity {
    let title: String
    var iconUrl: URL? = nil
    var linkUrl: URL? = nil
}

struct FooterEntity {
    let title: String
    var iconURL: URL? = nil
}
