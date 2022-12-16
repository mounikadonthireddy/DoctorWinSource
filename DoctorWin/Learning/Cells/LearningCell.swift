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
    @IBOutlet weak var rating: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        courseImage.setCornerRadiusWithBorderColor(radius: 8, color: UIColor.lightGray, borderWidth: 0.2)
    }
    func configureCell(data: CourseModel) {
        courseName.text = data.name ?? ""
        courseTime.text = data.duration ?? ""
//        courseVidoes.text = "\(data.number_of_lession ?? 0)"
//        rating.text = "(" +  "\(data.rating ?? "")" + ")"
//        departmentLbl.text = data.department ?? ""
        if let urlString = data.image {
            self.courseImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }
}
