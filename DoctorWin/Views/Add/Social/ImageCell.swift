//
//  ImageCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 13/05/22.
//

import UIKit

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var imageBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imageBtn.setCornerRadiusWithBorderColor(radius: 5, color: UIColor.lightGray, borderWidth: 0.5)
    }

}
