//
//  HomeViewModel.swift
//  ChefaaApp
//
//  Created by Ayman Salah on 8/20/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    
    
    private var offers = BehaviorRelay<[Offer]>(value: [])
    private var subCategories = BehaviorRelay<[Category]>(value: [])
    private var brands = BehaviorRelay<[Brand]>(value: [])
    private var bestselling = BehaviorRelay<[Product]>(value: [])
    private var advertisements = BehaviorRelay<[Advertisement]>(value: [])

    
    private var disposeBag = DisposeBag()
    
    func fetchRemoteHome() {
        NetworkManager.shared.getHome()
            .map({ $0 })
            .subscribe(
                onNext: { [weak self] response in
                    self?.offers.accept(response.data!.offers!)
                    self?.subCategories.accept(response.data!.subCategories!)
                    self?.brands.accept(response.data!.brands!)
                    self?.bestselling.accept(response.data!.bestSelling!)
                    self?.advertisements.accept(response.data!.advertisements!)
                },
                onError: { [weak self] error in
                    print("Error: -- \(error.localizedDescription)")
            }).disposed(by: disposeBag)
    }
    
    
    
    public func getOffers() -> BehaviorRelay<[Offer]> {
        return offers
    }
    
    public func getSubCategories() -> BehaviorRelay<[Category]> {
        return subCategories
    }
    
    public func getBrands() -> BehaviorRelay<[Brand]> {
        return brands
    }
    
    public func getBestsellings() -> BehaviorRelay<[Product]> {
        return bestselling
    }
    
    public func getAdvertisements() -> BehaviorRelay<[Advertisement]> {
        return advertisements
    }
}
