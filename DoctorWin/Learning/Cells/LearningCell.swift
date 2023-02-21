//
//  LearningCell.swift
//  DoctorWin
//
//  Created by AHP on 08/10/2565 BE.
//

import UIKit

class LearningCell: UICollectionViewCell {

    @IBOutlet weak var courseImage: UIImageView!
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var courseTime: UILabel!
    @IBOutlet weak var courseVidoes: UILabel!
    @IBOutlet weak var departmentLbl: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        courseImage.setCornerRadiusWithBorderColor(radius: 8, color: UIColor.lightGray, borderWidth: 0.2)
    }
    func configureCell(data: CourseModel) {
        courseName.text = data.category ?? ""
        courseTime.text = data.duration ?? ""
//        courseVidoes.text = "\(data.number_of_lession ?? 0)"
//        rating.text = "(" +  "\(data.rating ?? "")" + ")"
     departmentLbl.text = data.name ?? ""
        if let urlString = data.image {
            self.courseImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }
    func configureCell(data: LearningCategoryModel) {
        courseVidoes.text = "\(data.videos ?? 0)"
        courseTime.text = data.duration ?? ""
        departmentLbl.text = data.name ?? ""
       
//        rating.text = "\(data.videos ?? 0) Modules"
//        discount.text = "\(data.percentage_off ?? 0)% Off"
//        actualPrice.text = "\u{20B9} " + ( data.original_price ?? "")
//        discountPrice.text =  "\u{20B9} "  + ( data.offer_price ?? "")
        courseName.text = data.subcategory ?? ""
        if let urlString = data.image {
            self.courseImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }
}
