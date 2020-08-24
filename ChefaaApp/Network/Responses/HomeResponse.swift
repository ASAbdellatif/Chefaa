//
//  HomeResponse.swift
//  ChefaaApp
//
//  Created by Ayman Salah on 8/20/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import ObjectMapper

struct HomeResponse: Mappable {
    var subCategories: [Category]?
    var brands: [Brand]?
    var bestSelling: [Product]?
    var offers: [Offer]?
    var advertisements: [Advertisement]?
    var title: String?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        subCategories      <- map["subCategories"]
        brands             <- map["brands"]
        bestSelling        <- map["bestselling"]
        offers             <- map["landingPages"]
        advertisements     <- map["slider"]
        title              <- map["landing_page_title"]
    }
}
