//
//  ProfileSkillsCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 11/01/22.
//

import UIKit

class ProfileSkillsCell: UITableViewCell {
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var descriptionName: UILabel!
    @IBOutlet weak var edit : UIButton!
    @IBOutlet weak var skillsView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        skillsView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor(rgb: 0xE6E6E6), borderWidth: 0.5)

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func cellConfigureWith(section: Int, data:ProfileDataModel) {
        
        
        descriptionName.text = data.aboutMe ??  "Write something about you"
        
    }
    
}
