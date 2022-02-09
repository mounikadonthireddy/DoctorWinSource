//
//  ProfileDashboardCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 11/01/22.
//

import UIKit

class ProfileDashboardCell: UITableViewCell {
    @IBOutlet weak var casesCountLbl: UILabel!
    @IBOutlet weak var appliedCountLbl: UILabel!
    @IBOutlet weak var newsCountLbl: UILabel!
    @IBOutlet weak var articalsCountLbl: UILabel!
    @IBOutlet weak var storiesCountLbl: UILabel!
    @IBOutlet weak var pollsCountLbl: UILabel!
    @IBOutlet weak var followCountLbl: UILabel!
    @IBOutlet weak var followingCountLbl: UILabel!
    
    @IBOutlet weak var casesCountBtn: UIButton!
    @IBOutlet weak var appliedCountBtn: UIButton!
    @IBOutlet weak var newsCountBtn: UIButton!
    @IBOutlet weak var articalsCountBtn: UIButton!
    @IBOutlet weak var storiesCountBtn: UIButton!
    @IBOutlet weak var pollsCountBtn: UIButton!
    @IBOutlet weak var followCountBtn: UIButton!
    @IBOutlet weak var followingCountBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func cellConfigureWith(data: ProfileDataModel) {
        self.casesCountLbl.text = "\(data.casesCount)"
        self.appliedCountLbl.text = "\(data.appliedJobs ?? 0)"
        self.newsCountLbl.text = "\(data.newslikeCount)"
        self.articalsCountLbl.text = "\(data.articalsCount)"
        self.storiesCountLbl.text = "\(data.storiesCount)"
        self.pollsCountLbl.text = "\(data.pollsCount)"
        self.followCountLbl.text = "\(data.follow ?? 0)"
        self.followingCountLbl.text = "\(data.following ?? 0)"

    }
    
}
