//
//  ShopCVCell.swift
//  DoctorWin
//
//  Created by AHP on 05/07/2565 BE.
//

import UIKit

class ShopCVCell: UICollectionViewCell {
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productImage.setCornerRadius(radius: 5)
    }
    func configureCell(data: ShopModel) {
        productName.text = data.product_name
        productPrice.text = "$" + data.product_price
    
        self.productImage.sd_setImage(with: URL(string: data.image), placeholderImage: UIImage(named: "loginBg"))
    }
}
