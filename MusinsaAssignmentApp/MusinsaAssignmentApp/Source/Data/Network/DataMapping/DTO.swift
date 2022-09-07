//
//  DTO.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/15.
//

import Foundation

protocol Mappable {
    associatedtype MappedType
    func toDomain() -> MappedType
}

struct MusinsaDTO: Decodable, Mappable {
    let data: [SectionData]
    
    func toDomain() -> MusinsaEntity {
        let data = data.map {
            SectionEntity(
                contents: $0.contents.toDomain(),
                header: $0.header?.toDomain(),
                footer: $0.footer?.toDomain()
            )
        }
        return MusinsaEntity(data: data)
    }
}

extension MusinsaDTO {
    struct SectionData: Decodable {
        let contents: ContentsDTO
        let header: HeaderDTO?
        let footer: FooterDTO?
    }
}

protocol ItemDTOTpye { }

struct ContentsDTO: Decodable, Mappable {
    let type: ContentsType
    let items: [ItemDTOTpye]
//    let banners: [BannerDTO]?
//    let products: [ProductDTO]?
//    let styles: [StyleDTO]?
    
    enum CodingKeys: String, CodingKey {
        case type, items
//        case type
        case banners
        case products = "goods"
        case styles
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(ContentsType.self, forKey: .type)

        switch type {
        case .banner:
            items = try container.decode([BannerDTO].self, forKey: .banners)
        case .grid, .scroll:
            items = try container.decode([ProductDTO].self, forKey: .products)
        case .style:
            items = try container.decode([StyleDTO].self, forKey: .styles)
        }
    }
    
    func toDomain() -> ContentsEntity {
        switch type {
        case .banner:
            let entities = items.compactMap { ($0 as? BannerDTO)?.toDomain() }
            return ContentsEntity(contentsType: type.toDomain(), items: entities)
        case .grid, .scroll:
            let entities = items.compactMap { ($0 as? ProductDTO)?.toDomain() }
            return ContentsEntity(contentsType: type.toDomain(), items: entities)
        case .style:
            let entities = items.compactMap { ($0 as? StyleDTO)?.toDomain() }
            return ContentsEntity(contentsType: type.toDomain(), items: entities)
        }
    }
    
//    func toDomain() -> ContentsEntity {
//        switch type {
//        case .banner:
//            let entities = banners?.map { $0.toDomain() }
//            return ContentsEntity(contentsType: type.toDomain(), items: entities)
//        case .grid, .scroll:
//            let entities = products.map { $0.toDomain() }
//            return ContentsEntity(contentsType: type.toDomain(), items: entities)
//        case .style:
//            let entities = styles.map { $0.toDomain() }
//            return ContentsEntity(contentsType: type.toDomain(), items: entities)
//        }
//    }
}

extension ContentsDTO {
    enum ContentsType: String, Decodable, Mappable {
        case banner = "BANNER"
        case grid = "GRID"
        case scroll = "SCROLL"
        case style = "STYLE"
        
        func toDomain() -> ContentsEntity.`Type` {
            switch self {
            case .banner:
                return .banner
            case .grid:
                return .grid
            case .scroll:
                return .scroll
            case .style:
                return .style
            }
        }
    }
}

struct BannerDTO: Decodable, ItemDTOTpye, Mappable {
    let linkURL: String
    let thumbnailURL: String
    let title: String
    let description: String
    let keyword: String
    
    func toDomain() -> BannerEntity {
        return BannerEntity(
            linkUrl: URL(string: linkURL),
            thumbnailUrl: URL(string: thumbnailURL),
            title: title,
            description: description,
            keyword: keyword
        )
    }
}

struct ProductDTO: Decodable, ItemDTOTpye, Mappable {
    let linkURL: String
    let thumbnailURL: String
    let brandName: BrandName
    let price: Int
    let saleRate: Int
    let hasCoupon: Bool
    
    func toDomain() -> ProductEntity {
        return ProductEntity(
            linkUrl: URL(string: linkURL),
            thumbnailUrl: URL(string: thumbnailURL),
            brandName: brandName.rawValue,
            price: price.toFormattedWonString(),
            saleRate: saleRate == 0 ? nil : "\(saleRate)%",
            hasCoupon: hasCoupon
        )
    }
}

enum BrandName: String, Decodable {
    case 디스커버리익스페디션 = "디스커버리 익스페디션"
    case 아스트랄프로젝션 = "아스트랄 프로젝션"
    case 텐블레이드 = "텐블레이드"
}

struct StyleDTO: Decodable, ItemDTOTpye, Mappable {
    let linkURL: String
    let thumbnailURL: String
    
    func toDomain() -> StyleEntity {
        return StyleEntity(
            linkUrl: URL(string: linkURL),
            thumbnailUrl: URL(string: thumbnailURL)
        )
    }
}

struct FooterDTO: Decodable, Mappable {
    let type: FooterType
    let title: String
    let iconURL: String?
    
    func toDomain() -> FooterEntity {
        var footerEntity = FooterEntity(title: title)
        if let iconURL = iconURL { footerEntity.iconURL = URL(string: iconURL) }
        return footerEntity
    }
}

extension FooterDTO {
    @frozen
    enum FooterType: String, Decodable {
        case more = "MORE"
        case refresh = "REFRESH"
    }
}

struct HeaderDTO: Decodable, Mappable {
    let title: String
    let iconURL: String?
    let linkURL: String?
    
    func toDomain() -> HeaderEntity {
        var headerEntity = HeaderEntity(title: title)
        if let iconURL = iconURL { headerEntity.iconUrl = URL(string: iconURL) }
        if let linkURL = linkURL { headerEntity.linkUrl = URL(string: linkURL) }
        return headerEntity
    }
}
