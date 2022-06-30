//
//  ShopCategoryCell.swift
//  DoctorWin
//
//  Created by AHP on 30/06/2565 BE.
//

import UIKit

class ShopCategoryCell: UICollectionViewCell {
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(data: ShopCategoryModel) {
        categoryName.text = data.name
       
        self.categoryImage.sd_setImage(with: URL(string: data.image), placeholderImage: UIImage(named: "loginBg"))
        
    }

}
