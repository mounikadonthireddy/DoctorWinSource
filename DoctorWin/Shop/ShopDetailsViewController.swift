//
//  ShopDetailsViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 05/05/22.
//

import UIKit

class ShopDetailsViewController: ViewController {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productCondition: UILabel!
    @IBOutlet weak var productModel: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productLocation: UILabel!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personSpeciality: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var chatBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var uploadBtn: UIButton!
    var imagesArray :[ProductImageModel] = []
    var productId = 0
    var productVM = ShopDetailsViewModel()
    var timer: Timer?
       var currentImage: UIImage?
       var currentIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productVM.delegate = self
        self.loadProductDetails()
        uploadBtn.setCornerRadius(radius: Float(uploadBtn.frame.width)/2)
       personImage.setCornerRadius(radius: Float(personImage.frame.width)/2)
        backBtn.setCornerRadius(radius: Float(backBtn.frame.width)/2)
        // Do any additional setup after loading the view.
        
    }
  
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction(){
        if imagesArray.count > 0 {
            currentIndex = (currentIndex == imagesArray.count - 1) ? 0 : currentIndex + 1
            let urlString = self.imagesArray[self.currentIndex].image
        
            self.productImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
           
            self.currentImage = self.productImage.image
            self.pageControl.currentPage = self.currentIndex
        
    }
    }
    func loadProductDetails() {
        self.showLoader()
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
    @IBAction func uploadClicked(_ sender: Any) {
        
    }
    @IBAction func chatClicked(_ sender: Any) {
        
    }


}
extension ShopDetailsViewController: ProductDetailsDelegate {
    func didReciveProductData(response: ProductDetailsModel?, error: String?) {
        self.dismiss()
        if let data = response {
            productName.text = data.product_name
            productPrice.text = "$" + data.product_price
            productLocation.text =  data.location
            productCondition.text =  data.product_condition
            productDescription.text =  data.description
            productModel.text =  data.product_models ?? ""
            pageControl.numberOfPages = data.image.count
            personName.text = data.profile_name
            personSpeciality.text = data.speciality
            imagesArray = data.image
            self.startTimer()
            if let urlString = data.profileImage {
                self.personImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
            }
        }
    }
    
    
}
