//
//  Models.swift
//  HutechSolutionsTask
//
//  Created by LokeshReddy on 02/04/21.
//

import Foundation

// MARK: - ExploreData
struct ExploreData: Codable {
    let success: Bool
    let components: [Component]
}

    // MARK: - Component
struct Component: Codable {
    let name: String
    let staticBanner: [Banner]?
    let categorydata: [Categorydatum]?
    let adsBanner: [Banner]?
   // let carouselBanner: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case name
        case staticBanner = "StaticBanner"
        case categorydata
        case adsBanner = "AdsBanner"
       // case carouselBanner = "CarouselBanner"
    }
}
    // MARK: - Banner
struct Banner: Codable {
    let bannerID: Int
    let bannerName, bannerDescription, bannerAlt, bannerImage: String
    let urlType: String
    let urlID: Int

    enum CodingKeys: String, CodingKey {
        case bannerID = "banner_id"
        case bannerName = "banner_name"
        case bannerDescription = "banner_description"
        case bannerAlt = "banner_alt"
        case bannerImage = "banner_image"
        case urlType = "url_type"
        case urlID = "url_id"
    }
}
    // MARK: - Categorydatum
struct Categorydatum: Codable {
    let categoryID: Int
    let categoryName, categoryDescription, categoryPicture: String

    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case categoryName = "category_name"
        case categoryDescription = "category_description"
        case categoryPicture = "category_picture"
    }
}
