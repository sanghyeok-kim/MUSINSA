//
//  DTO.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/08/21.
//

import Foundation

struct ProductDTO {
    let linkURL: URL?
    let thumbnailURL: URL?
    let brandName: String
    let price: String
    let saleRate: String?
    let hasCoupon: Bool
    
    init(product: Product) {
        self.linkURL = URL(string: product.linkURL)
        self.thumbnailURL = URL(string: product.thumbnailURL)
        self.brandName = product.brandName.rawValue
        self.price = product.price.toFormattedWonString()
        self.saleRate = product.saleRate == 0 ? nil : "\(product.saleRate)%"
        self.hasCoupon = product.hasCoupon
    }
}

struct BannerDTO {
    let linkURL: URL?
    let thumbnailURL: URL?
    let title: String
    let description: String
    let keyword: String
    
    init(banner: Banner) {
        self.linkURL = URL(string: banner.linkURL)
        self.thumbnailURL = URL(string: banner.thumbnailURL)
        self.title = banner.title
        self.description = banner.description
        self.keyword = banner.keyword
    }
}

struct StyleDTO {
    let linkURL: URL?
    let thumbnailURL: URL?
    
    init(style: Style) {
        self.linkURL = URL(string: style.linkURL)
        self.thumbnailURL = URL(string: style.thumbnailURL)
    }
}

struct HeaderDTO {
    let title: String
    var iconURL: URL? = nil
    var linkURL: URL? = nil
    
    init(header: Header) {
        self.title = header.title
        if let headerIconUrl = header.iconURL {
            self.iconURL = URL(string: headerIconUrl)
        }
        if let headerlinkUrl = header.linkURL {
            self.linkURL = URL(string: headerlinkUrl)
        }
    }
}

struct FooterDTO {

//    enum FooterType {
//        case more
//        case refresh
//        case none
//
//        
//    }
//
//    let type: FooterType
//    let title: String
//    var iconURL: URL? = nil

//    init(footer: Footer) {
//        self.type = FooterType(rawValue: footer.type)
//        self.title = footer.title
//        if let footerIconUrl =  footer.iconURL {
//            self.iconURL = URL(string: footerIconUrl)
//        }
//    }
}