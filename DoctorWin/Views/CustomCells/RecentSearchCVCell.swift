//
//  RecentSearchCVCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 11/01/22.
//

import UIKit

class RecentSearchCVCell: UICollectionViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var postedDate: UILabel!
    @IBOutlet weak var nameLable: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor(rgb: 0xE6E6E6), borderWidth: 0.5)
        nameLable.setCornerRadius(radius: Float(self.nameLable.frame.height)/2)

        // Initialization code
    }

}
