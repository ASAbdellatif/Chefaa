//
//  Offer.swift
//  ChefaaApp
//
//  Created by Ayman Salah on 8/20/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import ObjectMapper

struct Offer: Mappable {
    var id: Int?
    var name: String?
    var image: String?
    var description: String?
    var slug: String?
    var isActive: Int?
    var isMain: Int?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id             <- map["id"]
        name           <- map["title"]
        image          <- map["image"]
        description    <- map["description"]
        slug           <- map["slug"]
        isActive       <- map["is_active"]
        isMain         <- map["is_main"]
    }
}
