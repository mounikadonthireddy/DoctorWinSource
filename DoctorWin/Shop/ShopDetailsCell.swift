//
//  ShopDetailsCell.swift
//  DoctorWin
//
//  Created by AHP on 07/10/2565 BE.
//

import UIKit

class ShopDetailsCell: UITableViewCell {
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productCondition: UILabel!
    @IBOutlet weak var productModel: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personSpeciality: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        personImage.setCornerRadius(radius: Float(personImage.frame.width)/2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCellwith(data: ProductDetailsModel) {
        productName.text = data.product_name
        productPrice.text = "$" + data.product_price
        productCondition.text =  data.product_condition
        productDescription.text =  data.description
        productModel.text =  data.product_models ?? ""
        personName.text = data.profile_name
        personSpeciality.text = data.speciality
        if let urlString = data.profileImage {
            self.personImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }
}
