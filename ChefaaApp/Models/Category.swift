//
//  Category.swift
//  ChefaaApp
//
//  Created by Ayman Salah on 8/20/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import ObjectMapper

struct Category: Mappable {
    var id: Int?
    var title: String?
    var image: String?
    var slug: String?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id      <- map["id"]
        title   <- map["title"]
        image   <- map["image"]
        slug    <- map["slug"]
    }
}
