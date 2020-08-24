//
//  Slider.swift
//  ChefaaApp
//
//  Created by Ayman Salah on 8/24/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import ObjectMapper

struct Advertisement: Mappable {
    var id: Int?
    var title: String?
    var image: String?
    var url: String?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id      <- map["id"]
        title   <- map["title"]
        image   <- map["image"]
        url     <- map["url"]
    }
}
