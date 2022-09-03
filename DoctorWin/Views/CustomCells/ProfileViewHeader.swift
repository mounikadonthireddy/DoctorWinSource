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
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var followingBtn: UIButton!
    @IBOutlet weak var viewBtn: UIButton!
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["Home","Post", "Cases", "Questions", "Answers"])
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
        interfaceSegmented.delegate = self
        viewBtn.setCornerRadius(radius: 10)
        profileImage.setCornerRadius(radius: Float(profileImage.frame.width)/2)
    }
    func configureView(data:ProfileDataModel) {
        profileName.text = data.profileName ?? ""
        profileQualification.text = data.qualification ?? ""
        profileLocation.text  = (data.speciality ?? "") + (data.currentLocation ?? "")
        
        followBtn.setTitle("\(data.follow ?? 0) Follow", for: .normal)
        
        followingBtn.setTitle("\(data.following ?? 0) Following", for: .normal)
        if let urlString = data.profileImage {
            self.profileImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "loginBg"))
        }
        
    }
    
}
extension ProfileViewHeader: CustomSegmentedControlDelegate {
    
    func change(to index: Int) {
        //self.loadMyArticles(index: index)
    }
}
