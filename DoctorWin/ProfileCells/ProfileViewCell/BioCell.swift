//
//  BioCell.swift
//  DoctorWorks
//
//  Created by AHP on 01/09/2565 BE.
//

import UIKit

class BioCell: UITableViewCell {
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var profileSummary: UILabel!
    @IBOutlet weak var editBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     //   editBtn.setCornerRadius(radius: 15)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func cellConfigureWith(data: ProfileDataModel) {
        self.profileSummary.text = data.aboutMe ?? "write something about you"
        
    }
    
    
}
