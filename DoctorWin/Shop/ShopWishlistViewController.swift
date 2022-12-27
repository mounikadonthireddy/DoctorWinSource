//
//  ShopWishlistViewController.swift
//  DoctorWin
//
//  Created by AHP on 05/07/2565 BE.
//

import UIKit

class ShopWishlistViewController: ViewController {
    
    @IBOutlet weak var shopCollectionView: UICollectionView!
    @IBOutlet weak var shopCVLayout: UICollectionViewFlowLayout!
    var shopVM = ShopViewModel()
    var salesArray: [ShopModel] = []
    var recentArray: [ShopModel] = []
    var bookmarkArray: [ShopModel] = []
    var titleArray  :[ String] = ["Your Sale List", "Recently Viewed", "Bookmarks"]
    let collectionViewHeaderFooterReuseIdentifier = "ShopWishlistHeaderView"
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        shopCollectionView.register(UINib.init(nibName: "ShopCVCell", bundle: nil), forCellWithReuseIdentifier: "ShopCVCell")
        shopCVLayout.scrollDirection = .vertical
        shopCVLayout.minimumLineSpacing = 0
        shopCVLayout.minimumInteritemSpacing = 0
        shopCVLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        shopCollectionView.register(UINib(nibName: collectionViewHeaderFooterReuseIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: collectionViewHeaderFooterReuseIdentifier)
//        tableView.register(TitleView.nib, forHeaderFooterViewReuseIdentifier: TitleView.identifier)
//        tableView.contentInsetAdjustmentBehavior = .never
//        tableView.register(UINib(nibName: "ShopWishlistCell", bundle: nil), forCellReuseIdentifier: "ShopWishlistCell")
//
        shopVM.delegate1 = self
        self.loadSalesList()
        self.loadRecentList()
        self.loadBookmarkList()
       
        // Do any additional setup after loading the view.
    }
    func loadSalesList() {
        self.showLoader()
        shopVM.getShopUploadData(userID: User.shared.userID)
    }
    func loadRecentList() {
        self.showLoader()
        shopVM.getShopRecentData(userID: User.shared.userID)
    }
    func loadBookmarkList() {
        self.showLoader()
        shopVM.getShopWishlistData(userID: User.shared.userID)
    }
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension ShopWishlistViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ShopWishlistCell
        = tableView.dequeueReusableCell(withIdentifier: "ShopWishlistCell") as! ShopWishlistCell

        cell.cellConfigure(sale: salesArray, recent: recentArray, bookmark: bookmarkArray)
       
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TitleView.identifier) as? TitleView {
            headerView.backgroundColor = UIColor.red
            headerView.titleLabel.text = titleArray[section]
            return headerView
        }
        
        return nil
        
    }
    
}
extension ShopWishlistViewController: ShopWishlistDelegate {
    func didReciveBookmarkShopData(response: ShopResponseModel?, error: String?) {
        self.dismiss()
        if let data = response {
            bookmarkArray = data.shopResponse ?? []
        }
        self.shopCollectionView.reloadData()
    }
    
    func didReciveUploadShopData(response: ShopResponseModel?, error: String?) {
        self.dismiss()
        if let data = response {
            salesArray = data.shopResponse ?? []
        }
        self.shopCollectionView.reloadData()
    }
    
    func didReciveRecentShopData(response: ShopResponseModel?, error: String?) {
        self.dismiss()
        if let data = response {
            recentArray = data.shopResponse ?? []
        }
        self.shopCollectionView.reloadData()

    }
    
    
}

extension ShopWishlistViewController: UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return salesArray.count
        } else if section  == 1 {
            return recentArray.count
        } else {
            return bookmarkArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ShopCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCVCell", for: indexPath) as! ShopCVCell
        if indexPath.section == 0 {
            cell.configureCell(data: salesArray[indexPath.row])
        } else if indexPath.section  == 1 {
            cell.configureCell(data: recentArray[indexPath.row])
        } else {
            cell.configureCell(data: bookmarkArray[indexPath.row])
        }
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/2 - 10
        return CGSize(width: yourWidth, height: 195)
        
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
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let str = UIStoryboard(name: "Shop", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "ShopDetailsViewController") as! ShopDetailsViewController
        if indexPath.section == 0 {
            nextVC.productId = salesArray[indexPath.row].id ?? 0
        } else  if indexPath.section == 0 {
            nextVC.productId = recentArray[indexPath.row].id ?? 0
        } else {
            nextVC.productId = bookmarkArray[indexPath.row].id ?? 0
        }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {

        case UICollectionView.elementKindSectionHeader:
            let headerView: ShopWishlistHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: collectionViewHeaderFooterReuseIdentifier, for: indexPath) as! ShopWishlistHeaderView
                
            headerView.titleLbl.text = titleArray[indexPath.section]
            
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 60)
    }
    
}
