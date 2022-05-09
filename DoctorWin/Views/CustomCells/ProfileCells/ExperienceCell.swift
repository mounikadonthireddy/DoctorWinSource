//
//  ExperienceCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 03/01/22.
//

import UIKit

class ExperienceCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var experienceView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // experienceView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor(rgb: 0xE6E6E6), borderWidth: 0.5)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(data: ExperienceModel) {
        title.text = data.designation ?? ""
        subTitle.text = (data.department ?? "") + ", " + (data.city ?? "")
        date.text = (data.start_date ?? "")  + " to " + (data.end_date ?? "")
    }
    
}
