//
//  SegmentCell.swift
//  DoctorWin
//
//  Created by AHP on 26/02/2566 BE.
//

import UIKit

class SegmentCell: UICollectionViewCell {
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
            didSet{
                interfaceSegmented.setButtonTitles(buttonTitles: ["Groups", "Accounts", "Create Group"])
                interfaceSegmented.selectorViewColor = .blue
                interfaceSegmented.selectorTextColor = .black
            }
        }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
