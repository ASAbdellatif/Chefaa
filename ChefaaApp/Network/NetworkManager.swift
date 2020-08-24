//
//  NetworkManager.swift
//  ChefaaApp
//
//  Created by Ayman Salah on 8/20/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Moya_ObjectMapper


class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let provider = MoyaProvider<ApiService>()
    let disposeBag: DisposeBag = DisposeBag()
    
    private init() {}
    
    
    func getHome() -> Observable<CommonResponse<HomeResponse>> {
        return provider.rx.request(.getHome)
            .mapObject(CommonResponse<HomeResponse>.self)
            .asObservable()
    }
    
}
