//
//  HomeDetailsImageCell.swift
//  DoctorWin
//
//  Created by AHP on 17/10/2565 BE.
//

import UIKit

class HomeDetailsImageCell: UITableViewCell {
    @IBOutlet weak var discussion: UILabel!
    @IBOutlet weak var likeLable: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var wishlistBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var bookmarkImage: UIImageView!
    @IBOutlet weak var imageHeiht: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureData(homeModel: HomeDataModel) {
       
//        if let value = homeModel.discussionCount {
//            self.discussion.text = "\(String(describing: value))"
//        }
//        if let value1 = homeModel.likeCount {
//            self.likeLable.text = "\(String(describing: value1))"
//        }
//
//        if let urlString = homeModel.postImage {
//            self.postImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
//        } else {
//            imageHeiht.constant  = 0
//        }
//        //  self.descriptionLable.text = homeModel.chiefComplaint
//        if homeModel.bookmarkStatus ?? false {
//            bookmarkImage.image = UIImage(named: "fmark")
//        }
//     
//        if homeModel.likeStatus ?? false {
//            likeImage.image = UIImage(named: "fheart")
//        }
//        wishlistBtn.tag = homeModel.postId
//        saveBtn.tag = homeModel.postId
        
    }
    @IBAction func likeClicked(_ sender: UIButton) {
//        let request = ComplaintLikeRequest(achievement_id: "\(sender.tag)", dworks_id: User.shared.userID)
//        let count = Int(likeLable.text ?? "0")
//        let resource = HomeResource()
//        resource.likeComplaint(request: request) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let data) :
//                    if data.likes == true {
//                        self.likeImage.image = UIImage(named: "fheart")
//                        self.likeLable.text = "\(data.like_count ?? 0)"
//                    } else {
//                        self.likeImage.image = UIImage(named: "heart")
//                        self.likeLable.text = "\((count ?? 1) - 1)"
//                    }
//                case .failure(_):
//                    print("")
//                }
//            }
//            
//        }
        
    }
  
    @IBAction  func saveClicked(_ sender: UIButton) {
//        let request = ComplaintLikeRequest(achievement_id: "\(sender.tag)", dworks_id: User.shared.userID)
//
//        let resource = HomeResource()
//        resource.saveComplaint(request: request) { result in
//            print(result)
//            DispatchQueue.main.async {
//                switch result {
//                case .success( let data):
//                    if data.bookmark == true {
//                        self.bookmarkImage.image = UIImage(named: "fmark")
//                    }
//                    else {
//                        self.bookmarkImage.image = UIImage(named: "mark")
//                    }
//                case .failure: break
//                    //debug
//                }
//            }
//
//        }
    }
    @IBAction  func shareClicked(_ sender: UIButton) {
        
    }
    
}
