//
//  ShopDetailsViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 05/05/22.
//

import UIKit

class ShopDetailsViewController: ViewController {
    @IBOutlet weak var productLocation: UILabel!
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var chatBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var wishlistBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    var imagesArray :[ProductImageModel] = []
    var productId = 0
    var productVM = ShopDetailsViewModel()
    var productDetails: ProductDetailsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productVM.delegate = self
        self.loadProductDetails()
        wishlistBtn.setCornerRadius(radius: Float(wishlistBtn.frame.width)/2)
        shareBtn.setCornerRadius(radius: Float(shareBtn.frame.width)/2)
        
        backBtn.setCornerRadius(radius: Float(backBtn.frame.width)/2)
        // Do any additional setup after loading the view.
        detailsTableView.register(UINib(nibName: "ImageSwipeCell", bundle: nil), forCellReuseIdentifier: "ImageSwipeCell")
        detailsTableView.register(UINib(nibName: "ShopDetailsCell", bundle: nil), forCellReuseIdentifier: "ShopDetailsCell")

    }
    
    
    func loadProductDetails() {
       // self.showLoader()
        productVM.getShopData(userID: User.shared.userID, productId: productId)
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func bookmarkClicked(_ sender: Any) {
        
    }
    @IBAction func shareClicked(_ sender: Any) {
        
    }
    
    @IBAction func chatClicked(_ sender: Any) {
        
    }
}
extension ShopDetailsViewController: ProductDetailsDelegate {
    func didReciveProductData(response: ShopDetailsModel?, error: String?) {
        self.dismiss()
        if let data = response?.shopResponse {
            productDetails = data
            productLocation.text =  data.location
            detailsTableView.reloadData()
        }
    }
}
extension ShopDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = productDetails {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: ImageSwipeCell
            = tableView.dequeueReusableCell(withIdentifier: "ImageSwipeCell") as! ImageSwipeCell
            cell.loadCellBannerImages(data: productDetails?.image ?? [])
            return cell
        } else {
            let cell: ShopDetailsCell
            = tableView.dequeueReusableCell(withIdentifier: "ShopDetailsCell") as! ShopDetailsCell
            cell.configureCellwith(data: productDetails!)
            return cell
        }
       
    }
    
}
