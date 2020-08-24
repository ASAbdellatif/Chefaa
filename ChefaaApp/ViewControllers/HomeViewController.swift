//
//  HomeViewController.swift
//  ChefaaApp
//
//  Created by Ayman Salah on 8/20/20.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher
import ImageSlideshow

class HomeViewController: UIViewController {
    
    var homeViewModel = HomeViewModel()
    var brandsCollectionViewFlowLayout: UICollectionViewFlowLayout!
    var bestsellingCollectionViewFlowLayout: UICollectionViewFlowLayout!
    var offersCollectionViewFlowLayout: UICollectionViewFlowLayout!
    
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var offersTitleLabel: UILabel!
    @IBOutlet weak var subCategoriesTitleLabel: UILabel!
    @IBOutlet weak var brandsTitleLabel: UILabel!
    @IBOutlet weak var bestsellingTitleLabel: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var showAllBrandsButton: UIButton!
    @IBOutlet weak var showAllBestsellingButton: UIButton!

    
    @IBOutlet weak var slideshow: ImageSlideshow!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var subCateogriesCollectionView: UICollectionView! {
        didSet {
            subCateogriesCollectionView.backgroundColor = .clear
            subCateogriesCollectionView.collectionViewLayout = subCategoriesCollectionViewColumnLayout
            subCateogriesCollectionView.contentInsetAdjustmentBehavior = .always
        }
    }
    
    @IBOutlet weak var brandsCollectionView: UICollectionView! {
        didSet {
            brandsCollectionView.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var bestsellingCollectionView: UICollectionView! {
        didSet {
            bestsellingCollectionView.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var offersCollectionView: UICollectionView! {
        didSet {
            offersCollectionView.backgroundColor = .clear
        }
    }
    
    
    @IBOutlet weak var offersCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectioViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var brandsCollectionViewHeights: NSLayoutConstraint!
    @IBOutlet weak var bestsellingCollectioViewHeightConstraint: NSLayoutConstraint!
    
    var disposeBag = DisposeBag()
    
    
    let subCategoriesCollectionViewColumnLayout = ColumnFlowLayout(
        cellsPerRow: 5,
        heightRatio: 1.6,
        minimumInteritemSpacing: 10,
        minimumLineSpacing: 10,
        sectionInset: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    )
    
    var sliderImages = [KingfisherSource]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
                
        let leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)

        leftBarButtonItem.tintColor = .black
        rightBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        showAllBrandsButton.setTitle(NSLocalizedString("show.all.button", comment: "Show All"), for: .normal)
        showAllBestsellingButton.setTitle(NSLocalizedString("show.all.button", comment: "Show All"), for: .normal)
        



        homeViewModel.fetchRemoteHome()
        
        initOffersCollectioView()
        initSubCategoriesCollectionView()
        initBrandsCollectionView()
        initBestsellingCollectionView()
        initSlider()
        initLabels()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initSearchBar()
    }
}


//MARK:- InitUI

extension HomeViewController {
    
    private func initSearchBar() {
        searchBar.delegate = self
        searchBar.backgroundColor = .clear
        searchBar.placeholder = NSLocalizedString("search.placeholder", comment: "Search")
        searchBar.roundCorners(radius: searchBar.bounds.height / 2)
        
        
        if let textField = self.searchBar.value(forKey: "searchField") as? UITextField {
            if let icon = textField.leftView as? UIImageView {
                icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
                icon.tintColor = .black
            }
            textField.font = UIFont.systemFont(ofSize: 13.0)
            textField.roundCorners(radius: textField.bounds.size.height/2)
            
        }
    }
    
    private func initLabels() {
        welcomeLabel.text = NSLocalizedString("welcome", comment: "welcome")
        offersTitleLabel.text = NSLocalizedString("offers.title", comment: "offers")
        subCategoriesTitleLabel.text = NSLocalizedString("subcategories.title", comment: "categories")
        brandsTitleLabel.text = NSLocalizedString("brands.title", comment: "brands")
        bestsellingTitleLabel.text = NSLocalizedString("bestselling.title", comment: "bestselling")
    }
    
    private func initSlider() {
        slideshow.pageIndicatorPosition = .init(horizontal: .center, vertical: .bottom)
        slideshow.slideshowInterval = 3.0
        
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = UIColor(named: "Chefaa-green")
        pageIndicator.pageIndicatorTintColor = .white
        slideshow.pageIndicator = pageIndicator
        
        homeViewModel.getAdvertisements().asObservable()
            .subscribe(onNext: { objects in
                if objects.count > 0 {
                    for ad in objects {
                        if ad.image != nil {
                            let processor = RoundCornerImageProcessor(cornerRadius: 40)
                            self.sliderImages.append(KingfisherSource(urlString: "\(Constants.ProductionServer.domainUrl)/\(ad.image!)",
                                options: [.processor(processor)])!)
                        }
                    }
                    self.slideshow.setImageInputs(self.sliderImages)
                }
            }).disposed(by: disposeBag)
    }
    
    private func initOffersCollectioView() {
        offersCollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width/2 - 25
        offersCollectionViewFlowLayout.itemSize = CGSize(width: width, height: width * 0.7)
        offersCollectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        offersCollectionViewFlowLayout.scrollDirection = .horizontal
        offersCollectionView.collectionViewLayout = offersCollectionViewFlowLayout
        
        homeViewModel.getOffers()
            .asObservable()
            .bind(to: offersCollectionView.rx.items(
                cellIdentifier: "offerCell",
                
                cellType: OfferCollectionViewCell.self)) { row, element, cell in
                    
                    if element.image != nil {
                        cell.imageView.kf.setImage(with: URL(string: "\(Constants.ProductionServer.domainUrl)/\(element.image!)"))
                        cell.imageView.roundCorners(radius: 10)
                    }
                    
        }.disposed(by: disposeBag)
        offersCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    private func initBestsellingCollectionView() {
        bestsellingCollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width/2 - 15
        bestsellingCollectionViewFlowLayout.itemSize = CGSize(width: width, height: width * 1.533)
        bestsellingCollectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        bestsellingCollectionViewFlowLayout.scrollDirection = .horizontal
        bestsellingCollectionView.collectionViewLayout = bestsellingCollectionViewFlowLayout
        
        homeViewModel.getBestsellings()
            .asObservable()
            .bind(to: bestsellingCollectionView.rx.items(cellIdentifier: "bestsellingCell", cellType: BestsellingCollectionViewCell.self)) { row, element, cell in
                
                if element.images != nil && element.images!.count > 0 {
                    cell.imageView.kf.setImage(with: URL(string: "\(Constants.ProductionServer.domainUrl)/\(element.images![0])"))
                }
                
                cell.titleLabel.text =  element.title!
                cell.priceLabel.text = "\(element.price!) EGP"
                cell.buyButton.roundCorners(radius: 10)
                cell.roundCorners(radius: 10, borderWidth: 1, borderColor: UIColor(named: "Input-gray"))
                
                
        }.disposed(by: disposeBag)
        bestsellingCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    // init subCategories Collection view with data
    private func initSubCategoriesCollectionView() {
        homeViewModel.getSubCategories()
            .asObservable()
            .bind(to: subCateogriesCollectionView.rx.items(
                cellIdentifier: "subCategoryCell", cellType: SubCategoryCollectionViewCell.self)) { row, element, cell in
                    let title = element.title!.replacingOccurrences(of: " ", with: "\n")
                    cell.titleLabel.text = title
                    cell.imageView.kf.setImage(with: URL(string: "\(Constants.ProductionServer.domainUrl)/\(element.image!)"))
        }.disposed(by: disposeBag)
        subCateogriesCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    // init bands collection view with data
    private func initBrandsCollectionView() {
        brandsCollectionViewFlowLayout = UICollectionViewFlowLayout()
        brandsCollectionViewFlowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width/4 - 15, height: UIScreen.main.bounds.width/4 - 15)
        brandsCollectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        brandsCollectionViewFlowLayout.scrollDirection = .horizontal
        brandsCollectionView.collectionViewLayout = brandsCollectionViewFlowLayout
        
        homeViewModel.getBrands()
            .asObservable()
            .bind(to: brandsCollectionView.rx.items(cellIdentifier: "brandCell", cellType: BrandCollectionViewCell.self)) { row, element, cell in
                
                if element.images != nil && element.images!.count > 0 {
                    cell.imageView.kf.setImage(with: URL(string: "\(Constants.ProductionServer.domainUrl)/\(element.images![0])"))
                    cell.roundCorners(radius: 10, borderWidth: 1, borderColor: UIColor(named: "Input-gray"))
                }
        }.disposed(by: disposeBag)
        brandsCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}


//MARK:- UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == subCateogriesCollectionView {
            collectioViewHeightConstraint.constant = subCateogriesCollectionView.collectionViewLayout.collectionViewContentSize.height
        } else if collectionView == brandsCollectionView {
            brandsCollectionViewHeights.constant = brandsCollectionViewFlowLayout.itemSize.height
        } else if collectionView == bestsellingCollectionView {
            bestsellingCollectioViewHeightConstraint.constant = bestsellingCollectionViewFlowLayout.itemSize.height
        } else if collectionView == offersCollectionView {
            offersCollectionViewHeightConstraint.constant = offersCollectionViewFlowLayout.itemSize.height
        }
        
        self.view.layoutIfNeeded()
        
    }
}


//MARK:- UISearchBarDelegate

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
