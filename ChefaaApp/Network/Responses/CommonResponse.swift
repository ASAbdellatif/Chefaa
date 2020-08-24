//
//  CommonResponse.swift
//  ChefaaApp
//
//  Created by Ayman Salah on 8/20/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import ObjectMapper

class CommonResponse<T: Mappable>: Mappable {
    var code: Int?
    var data: T?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        data      <- map["data"]
        code      <- map["code"]
    }
}

