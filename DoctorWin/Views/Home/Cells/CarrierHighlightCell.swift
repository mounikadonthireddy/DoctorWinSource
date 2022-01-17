//
//  CarrierHighlightCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 10/01/22.
//

import UIKit

class CarrierHighlightCell: UITableViewCell {
    @IBOutlet weak var resumeView: UIView!
    @IBOutlet weak var savedView: UIView!
    @IBOutlet weak var appliedView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.resumeView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor(rgb: 0xE46D47), borderWidth: 0.5)
        self.savedView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor(rgb: 0xE46D47), borderWidth: 0.5)

        self.appliedView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor(rgb: 0xE46D47), borderWidth: 0.5)

    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
