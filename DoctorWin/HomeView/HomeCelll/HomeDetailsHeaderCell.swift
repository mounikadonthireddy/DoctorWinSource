//
//  HomeDetailsHeaderCell.swift
//  DoctorWin
//
//  Created by AHP on 17/10/2565 BE.
//

import UIKit

class HomeDetailsHeaderCell: UITableViewCell {
    @IBOutlet weak var postedPersonName: UILabel!
    @IBOutlet weak var designation: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureData(homeModel: HomeDataModel) {
        self.postedPersonName.text = (homeModel.profileName ?? "")
        self.titleLable.text =  homeModel.postTitle ?? ""
        self.designation.text = homeModel.speciality ?? ""
        if let urlString = homeModel.profileImage {
            self.personImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
        
    }
    
}
