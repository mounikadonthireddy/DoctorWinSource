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
        productName.text = data.product_name
        productPrice.text = "$" + data.product_price
    
        self.productImage.sd_setImage(with: URL(string:ApiEndpoints.baseImageURL + data.image), placeholderImage: UIImage(named: "loginBg"))
        saveBtn.tag = data.id
    }
    @IBAction func saveClicked(_ sender:UIButton) {
       
            let request = ShopSaveRequest(productid:"\(sender.tag)", user_id: User.shared.userID)
            
            let resource = ShopResource()
            resource.saveProduct(request: request) { result in
                DispatchQueue.main.async {
                    if result.status  {
                        self.saveBtn.setImage( UIImage(named: "fmark"), for: .normal)
                    } else {
                        self.saveBtn.setImage( UIImage(named: "mark"), for: .normal)
                    }
                }
                
            }
        }
    
}

