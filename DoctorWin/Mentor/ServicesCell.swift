//
//  ServicesCell.swift
//  DoctorWin
//
//  Created by AHP on 18/03/2566 BE.
//

import UIKit

class ServicesCell: UICollectionViewCell {
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.bgView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor.lightGray, borderWidth: 0.7)
    }

}
