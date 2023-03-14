//
//  ProfileViewHeader.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 18/04/22.
//

import UIKit

class ProfileViewHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileLocation: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var followingBtn: UIButton!
    @IBOutlet weak var viewBtn: UIButton!
    @IBOutlet weak var bookmarkBtn: UIButton!
    @IBOutlet weak var bookmarkWidth: NSLayoutConstraint!
    var userID: String = ""
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["Post", "Cases", "Questions", "Answers"])
            interfaceSegmented.selectorViewColor = .black
            interfaceSegmented.selectorTextColor = .black
            interfaceSegmented.textColor = .lightGray
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
        profileName.text =  data.name ?? ""

        profileLocation.text  = (data.speciality ?? "") 
        
        followBtn.setTitle("\(data.follow_count ) Follow", for: .normal)
        
        followingBtn.setTitle("\(data.following_count ) Following", for: .normal)
        if let urlString = data.image {
            self.profileImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "loginBg"))
        }
        if let urlString1 = data.cover_image {
            self.coverImage.sd_setImage(with: URL(string: urlString1), placeholderImage: UIImage(named: "loginBg"))
        }
        userID = data.posted_id ?? ""
    }
    @IBAction  func followClicked(_ sender: UIButton) {
        
        let request = ComplaintFollowRequest(posted_id: userID)
        let resource = HomeResource()
        resource.followComplaint(request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if data != nil && data == true {
                        self.viewBtn.setTitle("Unfollow", for: .normal)
                        self.viewBtn.backgroundColor = UIColor(rgb: 0xE6E6E6)
                    } else {
                        self.viewBtn.setTitle("Follow", for: .normal)
                        self.viewBtn.backgroundColor = UIColor(rgb:0x1D9BF0)
                    }
                case .failure(_):
                    print("")
                }
                
            }
            
        }
    }
}
