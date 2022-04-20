//
//  ProfileCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 14/04/22.
//

import UIKit

class ProfileCell: UICollectionViewCell {

    @IBOutlet weak var iconTitle: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var bgView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.bgView.setCornerRadius(radius: 10)
    }

}
