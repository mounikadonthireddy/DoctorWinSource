//
//  UserHeaderView.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 09/05/22.
//

import UIKit

class UserHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var speciality: UILabel!
    @IBOutlet weak var desciptionLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var followingBtn: UIButton!
    @IBOutlet weak var viewBtn: UIButton!
    @IBOutlet weak var followViewHight: NSLayoutConstraint!
    @IBOutlet weak var followView: UIStackView!
    var userID: String = ""
    var displayStatus : Int = 0
    var selfId: Int = 0
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
    func configureView(data: ProfileModel) {
        profileName.text =  data.name ?? ""
        speciality.text  = (data.speciality ?? "")
        desciptionLbl.text = data.tell_me_about_youself ?? ""
        followBtn.setTitle("\(data.follow_count ) Follow", for: .normal)
        followingBtn.setTitle("\(data.following_count ) Following", for: .normal)
        if let urlString = data.image {
            self.profileImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "loginBg"))
        }
        if data.follow_status {
            self.viewBtn.setTitle("Unfollow", for: .normal)
        } else {
            self.viewBtn.setTitle("Follow", for: .normal)
        }
        userID = data.posted_id ?? ""
        followViewHight.constant = 30
        viewBtn.addTarget(self, action: #selector(followClicked(button:)), for: .touchUpInside)
    }
    func configureView(data: GroupProfileModel) {
        profileName.text =  data.name ?? ""
        desciptionLbl.text  = data.description ?? ""
        if let count = data.total_joined {
            speciality.text = "\(count) Participants"
        }
        if let urlString = data.image {
            self.profileImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "loginBg"))
        }
        if data.admin_status == true {
            self.viewBtn.setTitle("Edit", for: .normal)
        } else if data.joined_status ?? false {
            self.viewBtn.setTitle("Joined", for: .normal)
        } else {
            self.viewBtn.setTitle("Join", for: .normal)
        }
        followViewHight.constant = 0
        followView.isHidden = true
        displayStatus = 8
        selfId = data.id ?? 0
        if data.admin_status != true {
            viewBtn.addTarget(self, action: #selector(joinGroup(button:)), for: .touchUpInside)
        }
    }
    @objc func followClicked(button: UIButton) {
        let request = ComplaintFollowRequest(posted_id: userID)
        let resource = HomeResource()
        resource.followComplaint(request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if data != nil && data == true {
                        self.viewBtn.setTitle("Unfollow", for: .normal)
                    } else {
                        self.viewBtn.setTitle("Follow", for: .normal)
                    }
                case .failure(_):
                    print("")
                }
                
            }
            
        }
    }
    @objc func joinGroup(button: UIButton) {
        let request = LikeRequestModel(display_status: displayStatus, id: selfId, preference: Preference.join.rawValue)

        let resource = LikeSaveFollowResource()
        resource.addToWishslist(reqModel: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data) :
                    if data.status == true {
                        self.viewBtn.setTitle("Joined", for: .normal)
                    } else {
                        self.viewBtn.setTitle("Join", for: .normal)
                    }
                case .failure(_):
                    print("")
                }
            }

        }
    }
}
