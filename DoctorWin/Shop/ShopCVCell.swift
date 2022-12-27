//
//  ShopCVCell.swift
//  DoctorWin
//
//  Created by AHP on 05/07/2565 BE.
//

import UIKit
import SDWebImage
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
        productName.text = data.name ?? ""
        productPrice.text = "$" + (data.price ?? "")
        if let image = data.image {
    
        self.productImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + image), placeholderImage: UIImage(named: "loginBg"))
        }
    }
}
