//
//  CategoryTVCell.swift
//  DoctorWin
//
//  Created by AHP on 13/10/2565 BE.
//

import UIKit

class CategoryTVCell: UITableViewCell {
    @IBOutlet weak var courseImage: UIImageView!
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var courseDuration: UILabel!
    @IBOutlet weak var actualPrice: UILabel!
    @IBOutlet weak var discountPrice: UILabel!
    @IBOutlet weak var courseVidoes: UILabel!
    @IBOutlet weak var courseTime: UILabel!
    @IBOutlet weak var departmentLbl: UILabel!
    @IBOutlet weak var rating: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(data: LearningCategoryModel) {
        courseName.text = data.subject_title ?? ""
       // courseTime.text = data.duration ?? ""
        courseVidoes.text = "\(data.number_of_lession ?? 0)"
        rating.text = "(" +  "\(data.rating ?? "")" + ")"
        actualPrice.text = "\u{20B9} " + ( data.original_price ?? "")
        discountPrice.text =   data.offer_price ?? ""
        departmentLbl.text = data.department ?? ""
        if let urlString = data.image {
            self.courseImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }
}
