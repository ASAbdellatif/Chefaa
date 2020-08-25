//
//  Product.swift
//  ChefaaApp
//
//  Created by Ayman Salah on 8/20/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import ObjectMapper

struct Product: Mappable {
    var id: Int?
    var title: String?
    var slug: String?
    var isFavorite: Bool?
    var url: String?
    var quantity: Int?
    var verified: String?
    var status: String?
    var isOutofstock: Int?
    var views: Int?
    var isNotified: Bool?
    var pharmacyBranchId: Int?
    var purchaseCount: Int?
    var discount: Int?
    var discountType: Int?
    var subCategoryId: Int?
    var subCategoryTitle: String?
    var subCategoryName: String?
    var mainCategoryId: Int?
    var brand: Int?
    var images: [String]?
    var couponDescription: String?
    var description: String?
    var price: Double?
    var finalDiscount: Int?
    var addresses: [String]?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id      <- map["id"]
        title <- map["title"]
        slug <- map["slug"]
        isFavorite <- map["is_favorite"]
        url <- map["full_url"]
        quantity <- map["quantity"]
        verified <- map["verified"]
        status <- map["status"]
        isOutofstock <- map["is_outofstock"]
        views <- map["views"]
        isNotified <- map["is_notified"]
        pharmacyBranchId <- map["pharmacy_branch_id"]
        purchaseCount <- map["purchase_count"]
        discount <- map["discount"]
        discountType <- map["discount_type"]
        subCategoryId <- map["sub_category_id"]
        subCategoryTitle <- map["sub_category_title"]
        subCategoryName <- map["sub_category_name"]
        mainCategoryId <- map["main_category_id"]
        brand <- map["brand"]
        images <- map["images"]
        couponDescription <- map["coupon_description"]
        description <- map["description"]
        price <- map["price"]
        finalDiscount <- map["final_discount"]
        addresses <- map["addresses"]
    }
}

