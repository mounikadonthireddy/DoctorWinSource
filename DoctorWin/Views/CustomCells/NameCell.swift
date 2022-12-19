//
//  NameCell.swift
//  DoctorWin
//
//  Created by AHP on 19/12/2565 BE.
//

import UIKit

class NameCell: UICollectionViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nameLblHeight: NSLayoutConstraint!
    @IBOutlet weak var bgView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.setCornerRadius(radius: 10)
      
    }
}
