//
//  ProfileSummaryCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 11/01/22.
//

import UIKit

class ProfileSummaryCell: UITableViewCell {
    @IBOutlet weak var previewBtn: UIButton!
    @IBOutlet weak var previewView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        previewBtn.setCornerRadius(radius: Float(previewBtn.frame.height)/2)
        previewView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor(rgb: 0xE6E6E6), borderWidth: 0.5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
