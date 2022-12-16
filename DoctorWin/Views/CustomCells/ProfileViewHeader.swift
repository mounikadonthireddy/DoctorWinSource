//
//  ProfileViewHeader.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 18/04/22.
//

import UIKit

class ProfileViewHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileQualification: UILabel!
    @IBOutlet weak var profileLocation: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var followingBtn: UIButton!
    @IBOutlet weak var viewBtn: UIButton!
    @IBOutlet weak var bookmarkBtn: UIButton!
    @IBOutlet weak var resumeBtn: UIButton!
    @IBOutlet weak var mcqBtn: UIButton!
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["Post", "Cases", "Questions", "Answers"])
            interfaceSegmented.selectorViewColor = .blue
            interfaceSegmented.selectorTextColor = .blue
        }
    }
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        viewBtn.setCornerRadius(radius: 10)
        profileImage.setCornerRadius(radius: Float(profileImage.frame.width)/2)
    }
    func configureView(data:ProfileModel) {
        profileName.text = "DR. " + (data.name ?? "")
        profileQualification.text = data.hightest_qualification ?? ""
        profileLocation.text  = (data.speciality ?? "") + " At " + (data.location ?? "")
        
        followBtn.setTitle("\(data.follow_count ) Follow", for: .normal)
        
        followingBtn.setTitle("\(data.following_count ) Following", for: .normal)
        if let urlString = data.image {
            self.profileImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "loginBg"))
        }
        if let urlString1 = data.cover_image {
            self.coverImage.sd_setImage(with: URL(string: urlString1), placeholderImage: UIImage(named: "loginBg"))
        }
        
    }
    
}
