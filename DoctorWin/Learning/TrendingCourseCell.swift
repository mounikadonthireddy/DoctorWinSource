//
//  TrendingCourseCell.swift
//  DoctorWin
//
//  Created by AHP on 10/01/2566 BE.
//

import UIKit

class TrendingCourseCell: UICollectionViewCell {

    @IBOutlet weak var courseImage: UIImageView!
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var departmentLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        courseImage.setCornerRadiusWithBorderColor(radius: 8, color: UIColor.lightGray, borderWidth: 0.2)
    }
    func configureCell(data: CourseModel) {
        courseName.text = data.name ?? ""

        if let urlString = data.image {
            self.courseImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }
}
