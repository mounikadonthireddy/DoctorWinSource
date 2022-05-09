//
//  CarrierCategoryCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 20/04/22.
//

import UIKit

class CarrierCategoryCell: UICollectionViewCell {
    @IBOutlet weak var jobTypeImage: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var jobTypeName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.clipsToBounds = true
        self.bgView.layer.cornerRadius = 10
        jobTypeImage.setCornerRadius(radius: 35)
        // Initialization code
    }
    func configureCell(with data: JobCategoryDataModel) {
        self.jobTypeName.text = data.title

        if let urlString = data.image {
            self.jobTypeImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }
}
