//
//  ShopCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 05/05/22.
//

import UIKit

class ShopCell: UICollectionViewCell {
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var saveBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productImage.setCornerRadius(radius: 5)
    }
    func configureCell(data: ShopModel) {
        productName.text = data.name ?? ""
        productPrice.text = "$" + (data.price ?? "")
        if let image = data.image {
    
        self.productImage.sd_setImage(with: URL(string:ApiEndpoints.baseImageURL + image), placeholderImage: UIImage(named: "loginBg"))
        }
        if data.bookmark == true {
            saveBtn.setImage(UIImage(named: "fmark"), for: .normal)
        }
        saveBtn.tag = data.id ?? 0
    }
    @IBAction func saveClicked(_ sender:UIButton) {
       
            let request = ShopSaveRequest(productid:"\(sender.tag)", user_id: User.shared.userID)
            
            let resource = ShopResource()
            resource.saveProduct(request: request) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success( let data):
                        if data.status {
                            self.saveBtn.setImage( UIImage(named: "fmark"), for: .normal)
                        }
                        else {
                            self.saveBtn.setImage( UIImage(named: "mark"), for: .normal)
                        }
                    case .failure: break
                       //debug
                    }
                }
                
            }
        }
    
}

