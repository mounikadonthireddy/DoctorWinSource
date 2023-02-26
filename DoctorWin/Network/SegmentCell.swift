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
                interfaceSegmented.selectorViewColor = #colorLiteral(red: 0, green: 0.381624639, blue: 0.6041520834, alpha: 1)
                interfaceSegmented.selectorTextColor = #colorLiteral(red: 0, green: 0.381624639, blue: 0.6041520834, alpha: 1)
            }
        }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
