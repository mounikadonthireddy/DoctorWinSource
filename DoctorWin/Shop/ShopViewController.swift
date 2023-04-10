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
 
    override func viewDidLoad() {
        super.viewDidLoad()
        shopView.dropShadow()
        searchBtn.setCornerRadius(radius: Float(searchBtn.frame.height)/2)
      
        shopCollectionView.register(UINib.init(nibName: "ShopCell", bundle: nil), forCellWithReuseIdentifier: "ShopCell")
        shopCollectionView.register(UINib.init(nibName: "ShopCategoryCell", bundle: nil), forCellWithReuseIdentifier: "ShopCategoryCell")
        shopCollectionView.register(UINib.init(nibName: "ImageCVCell", bundle: nil), forCellWithReuseIdentifier: "ImageCVCell")
        
        
        shopCollectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: headerKind, withReuseIdentifier: Key.ReusableIdentifiers.sectionHeaderViewId)
        
        configureCompositionalLayout()
        shopVM.delegate = self
        // Do any additional setup after loading the view.
      
        loadShopData()
        loadShopCategoryData()
        loadShopBannerData()
       //
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

extension ShopViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configureCompositionalLayout() {
        
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, env) in
            if sectionNumber == 1  {
                return LayoutType.mentorImage.getLayout()
            } else if sectionNumber == 0 {
                return LayoutType.shopCategory.getLayout()
            } else if sectionNumber == 2 {
                return LayoutType.shop.getLayout()
            }  else {
                return LayoutType.mentorImage.getLayout()
            }
        }
    
        layout.register(SectionDecorationView.self, forDecorationViewOfKind: sectionBackground)
        shopCollectionView.setCollectionViewLayout(layout, animated: true )
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Key.ReusableIdentifiers.sectionHeaderViewId, for: indexPath) as! SectionHeaderView
        if indexPath.section == 2 {
            header.title.text = "Recommended Products"
        }
        header.title.textAlignment = .center
            return header
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            switch section {
            case 0:
                return categoryArray.count
            case 1:
                return 1
            case 2:
                return shopArray.count
    
            default:
                return 0
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell: ShopCategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCategoryCell", for: indexPath) as! ShopCategoryCell
            cell.bgView.setCornerRadiusWithBorderColor(radius: 5, color: UIColor.secondaryLabel, borderWidth: 0.5)
          cell.configureCell(data: categoryArray[indexPath.row])
            return cell
            
        } else if indexPath.section == 1 {
                let cell: ImageCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCVCell", for: indexPath) as! ImageCVCell
                cell.loadCellBannerImages(data: bannerArray)
                return cell
        } else  {
            let cell: ShopCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCell", for: indexPath) as! ShopCell
           cell.configureCell(data: shopArray[indexPath.row])
            return cell
        }
//        else {
//            return UICollectionViewCell()
//        }
      
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let str = UIStoryboard(name: "Shop", bundle: nil)
            let nextVC = str.instantiateViewController(withIdentifier: "ShopDetailsViewController") as! ShopDetailsViewController
            nextVC.productId = shopArray[indexPath.row].id ?? 0
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else if indexPath.section == 0 {
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let data = response {
                self.shopArray = data.shopResponse ?? []
            }
            print("shopppp12\(self.shopArray.count)")
            self.shopCollectionView.reloadData()
        }
    }
    
    func didReciveShopBannerData(response: [ImageBannerModel]?, error: String?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss()
            self.bannerArray = response ?? []
            print("banner\(self.bannerArray.count)")
            self.shopCollectionView.reloadData()
        }
    }
    
    func didReciveShopData(response: [ShopModel]?, error: String?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss()
            self.shopArray = response ?? []
            print("shopppp\(self.shopArray.count)")
            self.shopCollectionView.reloadData()
        }
    }
    
    func didReciveShopCategoryData(response: [ShopCategoryModel]?, error: String?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss()
            self.categoryArray = response ?? []
            print("categorrr\(self.categoryArray.count)")
            self.shopCollectionView.reloadData()
        }
        
    }
    
    
}
