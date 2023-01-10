//
//  ShopViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 05/05/22.
//

import UIKit

class ShopViewController: ViewController {

    var shopVM = ShopViewModel()
    var categoryArray : [ShopCategoryModel] = []
    var shopArray : [ShopModel] = []
    var bannerArray : [ImageBannerModel] = []
    @IBOutlet weak var shopCollectionView: UICollectionView!
    @IBOutlet weak var shopView: UIView!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var shopCVLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var categoryCVLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var bannerCVLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var bannerCVHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        shopView.dropShadow()
        searchBtn.setCornerRadius(radius: Float(searchBtn.frame.height)/2)
        bannerCVHeight.constant = 0
        categoryCollectionView.register(UINib.init(nibName: "ShopCategoryCell", bundle: nil), forCellWithReuseIdentifier: "ShopCategoryCell")
        shopCollectionView.register(UINib.init(nibName: "ShopCell", bundle: nil), forCellWithReuseIdentifier: "ShopCell")
        bannerCollectionView.register(UINib.init(nibName: "ImageCVCell", bundle: nil), forCellWithReuseIdentifier: "ImageCVCell")
        
        
        shopCVLayout.scrollDirection = .vertical
        shopCVLayout.minimumLineSpacing = 0
        shopCVLayout.minimumInteritemSpacing = 0
        shopCVLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        categoryCVLayout.scrollDirection = .horizontal
        categoryCVLayout.minimumLineSpacing = 0
        categoryCVLayout.minimumInteritemSpacing = 0
        categoryCVLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        bannerCVLayout.scrollDirection = .horizontal
        bannerCVLayout.minimumLineSpacing = 0
        bannerCVLayout.minimumInteritemSpacing = 0
        bannerCVLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        shopVM.delegate = self
        // Do any additional setup after loading the view.
        loadShopData()
       loadShopCategoryData()
        loadShopBannerData()
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    func loadShopData() {
       showLoader()
        shopVM.getShopData(userID: User.shared.userID, category: "")
    }
    func loadShopCategoryData() {
        showLoader()
        shopVM.getShopCategoryData(userID: User.shared.userID, pageNum: 0)
    }
    func loadShopBannerData() {
        showLoader()
        shopVM.getShopBannerData(userID: User.shared.userID)
    }
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func wishlistClicked(_ sender: Any) {
        let str = UIStoryboard(name: "Shop", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "ShopWishlistViewController") as! ShopWishlistViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @IBAction func personClicked(_ sender: Any) {
        
    }
    @IBAction func postClicked(_ sender: Any) {
        let str = UIStoryboard(name: "Add", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "SaleViewController") as! SaleViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension ShopViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return categoryArray.count
        } else  if collectionView == bannerCollectionView {
            if bannerArray.count > 0 {
                return 1
            }
            return 0
        } else {
            return shopArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            let cell: ShopCategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCategoryCell", for: indexPath) as! ShopCategoryCell
            cell.bgView.setCornerRadiusWithBorderColor(radius: 5, color: UIColor.secondaryLabel, borderWidth: 0.5)
            cell.configureCell(data: categoryArray[indexPath.row])
            return cell
            
        } else if collectionView == bannerCollectionView {
                let cell: ImageCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCVCell", for: indexPath) as! ImageCVCell
                cell.loadCellBannerImages(data: bannerArray)
                return cell
        } else {
            let cell: ShopCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCell", for: indexPath) as! ShopCell
            cell.configureCell(data: shopArray[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView == categoryCollectionView {
            let size = (categoryArray[indexPath.row].name as NSString).size(withAttributes: nil)
            return CGSize(width: size.width + 50, height: 35)
        } else  if collectionView == bannerCollectionView {
            return CGSize(width: bannerCollectionView.frame.size.width , height: 230)
        } else {
        let yourWidth = collectionView.bounds.width/2 - 10
        return CGSize(width: yourWidth, height: 195)
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) //.zero
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
          
            return 5
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           
            return 5
        }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == shopCollectionView {
            let str = UIStoryboard(name: "Shop", bundle: nil)
            let nextVC = str.instantiateViewController(withIdentifier: "ShopDetailsViewController") as! ShopDetailsViewController
            nextVC.productId = shopArray[indexPath.row].id ?? 0
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else if collectionView == categoryCollectionView {
            let type = categoryArray[indexPath.row].name
            let str = UIStoryboard(name: "Shop", bundle: nil)
            let nextVC = str.instantiateViewController(withIdentifier: "ShopCategoryViewController") as! ShopCategoryViewController
            nextVC.categorySelected = type
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    
}
extension ShopViewController: ShopDelegate {
    func didReciveShopData(response: ShopResponseModel?, error: String?) {
        if let data = response {
            shopArray = data.shopResponse ?? []
        }
        shopCollectionView.reloadData()
    }
    
    func didReciveShopBannerData(response: [ImageBannerModel]?, error: String?) {
        self.dismiss()
        bannerArray = response ?? []
        if bannerArray.count != 0 {
            bannerCVHeight.constant = 230
        }
        bannerCollectionView.reloadData()
    }
    
    func didReciveShopData(response: [ShopModel]?, error: String?) {
        self.dismiss()
        shopArray = response ?? []
        shopCollectionView.reloadData()
    }
    
    func didReciveShopCategoryData(response: [ShopCategoryModel]?, error: String?) {
        self.dismiss()
        categoryArray = response ?? []
        categoryCollectionView.reloadData()
        
    }
    
    
}
