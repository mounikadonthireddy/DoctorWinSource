//
//  PollTableViewCell.swift
//  DoctorWin
//
//  Created by N517325 on 03/11/21.
//

import UIKit



class PollTableViewCell: UITableViewCell {
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var postedPersonName: UILabel!
    @IBOutlet weak var postedDate: UILabel!
    @IBOutlet weak var discussion: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var wishlistBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var replyBtn: UIButton!
    @IBOutlet weak var replyTF: UITextField!
    @IBOutlet weak var option1: UILabel!
    @IBOutlet weak var option2: UILabel!
    @IBOutlet weak var option3: UILabel!
    @IBOutlet weak var option4: UILabel!
    @IBOutlet weak var option1Ration: NSLayoutConstraint!
    @IBOutlet weak var option2Ration: NSLayoutConstraint!
    @IBOutlet weak var option3Ration: NSLayoutConstraint!
    @IBOutlet weak var option4Ration: NSLayoutConstraint!
    @IBOutlet weak var option1Text: UILabel!
    @IBOutlet weak var option2Text: UILabel!
    @IBOutlet weak var option3Text: UILabel!
    @IBOutlet weak var option4Text: UILabel!
    @IBOutlet weak var option1Percent: UILabel!
    @IBOutlet weak var option2Percent: UILabel!
    @IBOutlet weak var option3Percent: UILabel!
    @IBOutlet weak var option4Percent: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var bookmarkImage: UIImageView!
    @IBOutlet weak var designation: UILabel!

    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        view1.setCornerRadiusWithBorderColor(radius: 5, color: UIColor.lightGray, borderWidth: 1)
        view2.setCornerRadiusWithBorderColor(radius: 5, color: UIColor.lightGray, borderWidth: 1)
        
        view3.setCornerRadiusWithBorderColor(radius: 5, color: UIColor.lightGray, borderWidth: 1)
        
        view4.setCornerRadiusWithBorderColor(radius: 5, color: UIColor.lightGray, borderWidth: 1)
        self.personImage.setCornerRadiusWithBorderColor(radius: 20, color: UIColor.lightGray, borderWidth: 0.2)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureData(homeModel: HomeDataModel) {
        self.designation.text = homeModel.speciality
        self.postedPersonName.text = homeModel.profileName
        self.titleLable.text = homeModel.pollTitle
        let days = Date().offsetFrom(dateStr: homeModel.postedData)
        self.postedDate.text = "Poll : \(days) ago"
        option1Text.text = homeModel.option1
        option2Text.text = homeModel.option2
        option3Text.text = homeModel.option3
        option4Text.text = homeModel.option4
        option1Percent.text = "\(homeModel.option1Value!)%  "
        option2Percent.text = "\(homeModel.option2Value!)%  "
        option3Percent.text = "\(homeModel.option3Value!)%  "
        option4Percent.text = "\(homeModel.option4Value!)%  "
        
        if let value1 = homeModel.option1Value {
            if value1 > 0 {
                option1Ration = option1Ration.setMultiplier(multiplier: CGFloat(value1)/100)
                option1.backgroundColor = UIColor(rgb: 0xBBDEFB)
            } else {
                option1.backgroundColor = UIColor.white
            }
        }
        if let value2 = homeModel.option2Value {
            if value2 > 0 {
                option2.backgroundColor = UIColor(rgb: 0xBBDEFB)
                option2Ration = option2Ration.setMultiplier(multiplier: CGFloat(value2)/100)
                
            } else {
                option2.backgroundColor = UIColor.white
            }
        }
        if let value3 = homeModel.option3Value {
            if value3 > 0 {
                option3.backgroundColor =  UIColor(rgb: 0xBBDEFB)

                option3Ration = option3Ration.setMultiplier(multiplier: CGFloat(value3)/100)
            } else {
                option3.backgroundColor = UIColor.white
            }
        }
        if let value4 = homeModel.option4Value {
            
            if value4 > 0 {
                option4.backgroundColor = UIColor(rgb: 0xBBDEFB)
                option4Ration = option4Ration.setMultiplier(multiplier: CGFloat(value4)/100)
            } else {
                option4.backgroundColor = UIColor.white
            }
        }
        if let value = homeModel.discussion {
            self.discussion.text = "\(String(describing: value)) Discussions"
            
        }
        if let likes = homeModel.likes {
            self.likeLabel.text = "\(likes) Likes"
        }
        if let votes = homeModel.votes {
            self.votesLabel.text = "\(votes) Votes"
        }
        
        if homeModel.follow != "False" {
            self.followBtn.setTitle("Following", for: .normal)
        }
        if homeModel.likeStatus ?? false {
            likeImage.image = UIImage(named: "fheart")
            
        }
        if homeModel.bookmarkStatus ?? false {
            bookmarkImage.image = UIImage(named: "bookmark")
        }
        if let urlString = homeModel.caseProfileImage {
            let finalUrlString = "http://3.132.212.116:8000" + urlString
            
            self.personImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }
    
}
extension NSLayoutConstraint {
    /**
     Change multiplier constraint
     
     - parameter multiplier: CGFloat
     - returns: NSLayoutConstraint
     */
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {
        
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
