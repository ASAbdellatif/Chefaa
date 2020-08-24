//
//  NetworkHelper.swift
//  ChefaaApp
//
//  Created by Ayman Salah on 8/20/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import Moya

enum ApiService {
    case getHome
}

extension ApiService: TargetType {
    
    // This is the base URL we'll be using, typically our server.
    var baseURL: URL {
        return URL(string: Constants.ProductionServer.baseURL)!
    }

    // This is the path of each operation that will be appended to our base URL.
    var path: String {
        switch self {
        case .getHome:
            return "store/home-page"
        }
    }

    // Here we specify which method our calls should use.
    var method: Moya.Method {
        switch self {
        case .getHome:
            return .get
       
        }
    }

    // Here we specify body parameters, objects, files etc.
    // or just do a plain request without a body.
    // In this example we will not pass anything in the body of the request.
    var task: Task {
        return .requestPlain
    }

    // These are the headers that our service requires.
    // Usually you would pass auth tokens here.
    var headers: [String: String]? {
        // get the language from userDefaults

        var header =  ["Content-type": "application/json", "lang": "en"]
                
        return header
    }

    // This is sample return data that you can use to mock and test your services,
    // but we won't be covering this.
    var sampleData: Data {
        return Data()
    }

}
