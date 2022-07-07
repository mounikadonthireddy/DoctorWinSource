//
//  ShopWishlistViewController.swift
//  DoctorWin
//
//  Created by AHP on 05/07/2565 BE.
//

import UIKit

class ShopWishlistViewController: ViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var shopVM = ShopViewModel()
    var salesArray: [ShopModel] = []
    var recentArray: [ShopModel] = []
    var bookmarkArray: [ShopModel] = []
    var titleArray  :[ String] = ["Your Sale List", "Recently Viewed", "Bookmarks"]
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        tableView.register(TitleView.nib, forHeaderFooterViewReuseIdentifier: TitleView.identifier)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(UINib(nibName: "ShopWishlistCell", bundle: nil), forCellReuseIdentifier: "ShopWishlistCell")
        
        shopVM.delegate1 = self
        self.loadSalesList()
       
       
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
        if salesArray.count > 0 {
            cell.salesArray = salesArray
          //  cell.collectionView.reloadData()
        }
        if bookmarkArray.count > 0 {
            cell.bookmarkArray = bookmarkArray
           // cell.collectionView.reloadData()
        }
        
        if recentArray.count > 0 {
            cell.recentArray = recentArray
            
        }
        cell.collectionView.reloadData()
        // cell.deleagte = self
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
    func didReciveBookmarkShopData(response: [ShopModel]?, error: String?) {
        self.dismiss()
        bookmarkArray = response ?? []
        self.tableView.reloadData()
    }
    
    func didReciveUploadShopData(response: [ShopModel]?, error: String?) {
        self.dismiss()
        salesArray = response ?? []
        self.loadRecentList()
        self.tableView.reloadData()
    }
    
    func didReciveRecentShopData(response: [ShopModel]?, error: String?) {
        self.dismiss()
        recentArray = response ?? []
        self.tableView.reloadData()
        self.loadBookmarkList()
    }
    
    
}
