//
//  SaleViewController.swift
//  DoctorWin
//
//  Created by AHP on 11/07/2565 BE.
//

import UIKit
import iOSDropDown

class SaleViewController: ViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var productPrice: UITextField!
    @IBOutlet weak var productCondition: UITextField!
    @IBOutlet weak var productCategory: DropDown!
    @IBOutlet weak var productModel: UITextField!
    @IBOutlet weak var productLocation: UITextField!
    @IBOutlet weak var mobileNumber: UITextField!
    var imageUpload : [AGImageStructInfo] = []
    var imagePicker: ImagePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        collectionView.register(UINib.init(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func postClicked(_ sender: UIButton) {
        let inputDict = ["category_name": "Book",
                         "product_name": "Book",
                         "product_condition": "Good",
                         "product_models": "LKG",
                         "product_price": "1000",
                         "location": "Hyderabad",
                         "phone": "114324545",
                         "description": "vsdfgsdfgdsfgdf"
        ]
        let parameters: [String: Any] = [
            "image": imageUpload
        ]
        let url = ApiEndpoints.baseUrl + ApiEndpoints.postProduct
        AGUploadImageWebServices(url: url, parameter: parameters, inputData: inputDict )
            .responseJSON { (json, eror) in
                self.dismiss()
            debugPrint(json)
        }
        
    }
}
extension SaleViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return 5
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: ImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.imageBtn.addTarget(self, action: #selector(imageClicked(button:)), for: .touchUpInside)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        let yourWidth = CGFloat(90)
        return CGSize(width: yourWidth, height: collectionView.bounds.height)
       
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2) //.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 2
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
       // self.imagePicker.present(from: sender)
    }
    @objc func imageClicked(button: UIButton) {
        self.imagePicker.present(from: button)
    }
    
    
}
extension SaleViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?, fileName: String?, fileType: String?) {
        imageUpload.append(AGImageStructInfo(fileName: fileName!, type: "image/jpeg", data: image!.toData()))

    }
    
}
