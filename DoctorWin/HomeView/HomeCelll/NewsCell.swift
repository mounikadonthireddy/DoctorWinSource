//
//  NewsCell.swift
//  DoctorWin
//
//  Created by N517325 on 22/10/21.
//

import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet weak var postedPersonName: UILabel!
    @IBOutlet weak var designation: UILabel!
    @IBOutlet weak var discussion: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var descriptionLable: ExpandableLabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var wishlistBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    // @IBOutlet weak var replyBtn: UIButton!
    @IBOutlet weak var replyTF: UITextField!
    weak var delegate: CellActionDelegate?
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var bookmarkImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        personImage.setCornerRadiusWithBorderColor(radius: 25, color: UIColor.lightGray, borderWidth: 0.2)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureData(homeModel: HomeDataModel) {
        
        self.postedPersonName.text = (homeModel.profileName ?? "")
        self.titleLable.text =  homeModel.title
        self.designation.text = homeModel.speciality

        
        if let value = homeModel.discussion {
            self.discussion.text = "\(String(describing: value))"
            
        }
//        self.followBtn.tag = homeModel.complaintId ?? 0
        if let urlString = homeModel.postedImage {
            self.postImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "loginBg"))
        }
//        self.descriptionLable.text = homeModel.discription
        if homeModel.bookmarkStatus ?? false {
            bookmarkImage.image = UIImage(named: "fmark")
        }
//        if homeModel.follow != "False" {
//            self.followBtn.setTitle("Following", for: .normal)
//        }
        if homeModel.likeStatus ?? false {
            likeImage.image = UIImage(named: "fheart")
            
        }
        if let urlString = homeModel.profileImage {
            let finalUrlString = "http://3.132.212.116:8000" + urlString
            
            self.personImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
        }
        wishlistBtn.tag = homeModel.id
        saveBtn.tag = homeModel.id
        // replyBtn.tag = homeModel.id ?? 0
    }
    func configureData(homeModel: NewsModel) {
        
        self.postedPersonName.text = (homeModel.ProfileName ?? "")
        self.titleLable.text =  homeModel.title
        self.designation.text = homeModel.speciality

        
        if let value = homeModel.discussions {
            self.discussion.text = "\(String(describing: value))"
            
        }
//        self.followBtn.tag = homeModel.complaintId ?? 0
        if let urlString = homeModel.image {
            self.postImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "loginBg"))
        }
//        self.descriptionLable.text = homeModel.discription
        if homeModel.bookmark_status {
            bookmarkImage.image = UIImage(named: "fmark")
        }
//        if homeModel.follow != "False" {
//            self.followBtn.setTitle("Following", for: .normal)
//        }
        if homeModel.like_status {
            likeImage.image = UIImage(named: "fheart")
            
        }
        if let urlString = homeModel.ProfileImage {
            let finalUrlString = "http://3.132.212.116:8000" + urlString
            
            self.personImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
        }
        wishlistBtn.tag = homeModel.id
        saveBtn.tag = homeModel.id
        // replyBtn.tag = homeModel.id ?? 0
    }
    @IBAction func likeClicked(_ sender: UIButton) {
        let request = ComplaintLikeRequest(complaint_id:"\(sender.tag)", user_id: User.shared.userID)
        
        let resource = HomeResource()
        resource.likeComplaint(request: request) { result in
            DispatchQueue.main.async {
                if result.status  {
                    self.likeImage.image = UIImage(named: "fheart")
                } else {
                    self.likeImage.image = UIImage(named: "heart")
                }
            }
            
        }
        
    }
    @IBAction  func followClicked(_ sender: UIButton) {
        let request = ComplaintFollowRequest(follow_id: "\(sender.tag)", user_id: User.shared.userID)
        let resource = HomeResource()
        resource.followComplaint(request: request) { result in
            DispatchQueue.main.async {
                if result != nil && result == true {
                    self.followBtn.setTitle("Following", for: .normal)
                } else {
                    self.followBtn.setTitle("Follow", for: .normal)
                }
            }
            
        }
    }
    @IBAction  func saveClicked(_ sender: UIButton) {
        let request = ComplaintLikeRequest(complaint_id:"\(sender.tag)", user_id: User.shared.userID)
        
        let resource = HomeResource()
        resource.saveComplaint(request: request) { result in
            DispatchQueue.main.async {
                if result.status  {
                    self.bookmarkImage.image = UIImage(named: "fmark")
                } else {
                    self.bookmarkImage.image = UIImage(named: "mark")
                }
            }
            
        }
    }
    @IBAction  func shareClicked(_ sender: UIButton) {
        
    }
    @IBAction func replyClicked(_ sender: UIButton) {
        replyTF.resignFirstResponder()
        if replyTF.text != "" {
            let request = PostReplyRequest(case_id:"\(sender.tag)", profile: User.shared.userID, comment: replyTF.text!)
            
            let resource = HomeResource()
            resource.replyComplaint(request: request) { result in
                DispatchQueue.main.async {
                    if result.status == "true" {
                        if let value = result.discussion {
                            self.discussion.text = "\(String(describing: value)) Discussions"
                            self.replyTF.text = ""
                        }
                    }
                    
                }
                
            }
        }
    }
}

extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = .zero
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
