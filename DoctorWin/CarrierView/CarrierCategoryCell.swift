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
        // Initialization code
    }
    func configureCell(with data: JobCategoryModel) {
        self.jobTypeName.text = data.category
        self.bgView.layer.cornerRadius = 10
      jobTypeImage.setCornerRadius(radius: 35)
        if let urlString = data.image {
            self.jobTypeImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }
   
    func configureCell(with data: CoursesCategoryModel) {
        self.jobTypeName.text = data.name_of_course ?? ""
        self.bgView.layer.cornerRadius = 10
        jobTypeImage.setCornerRadius(radius: 15)

        if let urlString = data.image {
            self.jobTypeImage.sd_setImage(with: URL(string:ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }
    
}
