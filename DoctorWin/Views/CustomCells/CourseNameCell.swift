//
//  CourseNameCell.swift
//  DoctorWin
//
//  Created by N517325 on 07/11/21.
//

import UIKit

class CourseNameCell: UICollectionViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nameLblHeight: NSLayoutConstraint!
    @IBOutlet weak var bgView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.name.setCornerRadiusWithBorderColor(radius: 10, color: UIColor.secondaryLabel, borderWidth: 1)
    }

}
