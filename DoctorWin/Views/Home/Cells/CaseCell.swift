//
//  CaseCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 20/04/22.
//

import UIKit

class CaseCell: UITableViewCell {

    @IBOutlet weak var postedPersonName: UILabel!
    @IBOutlet weak var designation: UILabel!
    @IBOutlet weak var discussion: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var descriptionLable: UILabel!
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
        
        self.postedPersonName.text = "DR. " + (homeModel.profileName ?? "")
        self.titleLable.text =  homeModel.title
        self.designation.text = homeModel.speciality

        
        if let value = homeModel.discussion {
            self.discussion.text = "\(String(describing: value)) Discussions"
            
        }
        self.followBtn.tag = homeModel.complaintId ?? 0
        if let urlString = homeModel.postedImage {
            let finalUrlString = ApiEndpoints.baseImageURL + urlString
            
            self.postImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
        }
        self.descriptionLable.text = homeModel.complaint
        if homeModel.bookmarkStatus ?? false {
            bookmarkImage.image = UIImage(named: "fmark")
        }
        if homeModel.follow != "False" {
            self.followBtn.setTitle("Following", for: .normal)
        }
        if homeModel.likeStatus ?? false {
            likeImage.image = UIImage(named: "fheart")
            
        }
        if let urlString = homeModel.caseProfileImage {
            let finalUrlString = "http://3.132.212.116:8000" + urlString
            
            self.personImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
        }
        wishlistBtn.tag = homeModel.id ?? 0
        saveBtn.tag = homeModel.id ?? 0
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
                if result != nil && result == "true" {
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