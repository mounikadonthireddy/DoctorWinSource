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
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(data: ShopCategoryModel) {
        categoryName.text = data.name
        if let image = data.image {
        self.categoryImage.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "loginBg"))
        
    }
    }
    func configureCell(data: FellowshipModel, selected:String) {
        print("selected text is \(selected)")
        categoryName.text = data.subcategory ?? ""
        if selected == categoryName.text {
            bgView.backgroundColor  = UIColor.red
        } else {
            bgView.backgroundColor  = UIColor.clear
        }
        self.categoryImage.isHidden = true
        self.categoryName.font = UIFont.systemFont(ofSize: 16)
        imageWidth.constant = 0
        bgView.setCornerRadius(radius: Float(bgView.frame.height)/2)
        bgView.setCornerRadiusWithBorderColor(radius: Float(bgView.frame.height)/2, color: UIColor.red, borderWidth: 0.4)
//
//        if let image = data.image {
//        self.categoryImage.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "loginBg"))
//
    }

}
