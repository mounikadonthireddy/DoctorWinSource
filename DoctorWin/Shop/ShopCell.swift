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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(data: ShopModel) {
        productName.text = data.product_name
        productPrice.text = "$" + data.product_price
    
        self.productImage.sd_setImage(with: URL(string: data.image), placeholderImage: UIImage(named: "loginBg"))
    }

}
