//
//  ExamCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 20/04/22.
//

import UIKit

class ExamCell: UITableViewCell {


    @IBOutlet weak var postedPersonName: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var followBtn: UIButton!
    
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var designation: UILabel!
    @IBOutlet weak var option1Btn: UIButton!
    @IBOutlet weak var option2Btn: UIButton!
    @IBOutlet weak var option3Btn: UIButton!
    @IBOutlet weak var option4Btn: UIButton!
    @IBOutlet weak var explainBtn: UIButton!

    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        option1Btn.setCornerRadiusWithBorderColor(radius: 5, color: UIColor.lightGray, borderWidth: 1)
        option2Btn.setCornerRadiusWithBorderColor(radius: 5, color: UIColor.lightGray, borderWidth: 1)
        
        option3Btn.setCornerRadiusWithBorderColor(radius: 5, color: UIColor.lightGray, borderWidth: 1)
        
        option4Btn.setCornerRadiusWithBorderColor(radius: 5, color: UIColor.lightGray, borderWidth: 1)
        self.personImage.setCornerRadiusWithBorderColor(radius: 20, color: UIColor.lightGray, borderWidth: 0.2)
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureData(homeModel: HomeDataModel) {
       
       

//        if homeModel.follow != "False" {
//            self.followBtn.setTitle("Following", for: .normal)
//        }
//        if homeModel.likeStatus ?? false {
//            likeImage.image = UIImage(named: "fheart")
//
//        }
//        if homeModel.bookmarkStatus ?? false {
//            bookmarkImage.image = UIImage(named: "fmark")
//        }
    
    }
    func configureData(homeModel: ExamsModel) {
        self.designation.text = homeModel.subject
        self.postedPersonName.text = homeModel.exam
        self.titleLable.text = homeModel.question
        self.option1Btn.setTitle("   A.\(homeModel.option1 )", for: .normal)
        self.option2Btn.setTitle("   B.\(homeModel.option2 )", for: .normal)
        self.option3Btn.setTitle("   C.\(homeModel.option3 )", for: .normal)
        self.option4Btn.setTitle("   D.\(homeModel.option4 )", for: .normal)

            self.setAnswer(selected: homeModel.selected_option ?? "", correct: homeModel.correct_answer)
        
       
//        if homeModel.follow != "False" {
//            self.followBtn.setTitle("Following", for: .normal)
//        }
//        if homeModel.likeStatus ?? false {
//            likeImage.image = UIImage(named: "fheart")
//
//        }
//        if homeModel.bookmarkStatus ?? false {
//            bookmarkImage.image = UIImage(named: "fmark")
//        }
        if homeModel.profileImage != "no Image" {
    
            self.personImage.sd_setImage(with: URL(string: homeModel.profileImage), placeholderImage: UIImage(named: "loginBg"))
        }
    }
    
        func setAnswer(selected: String, correct: String) {
            if selected != "" {
        switch correct  {
        case "A":
            self.option1Btn.backgroundColor = UIColor(rgb: 0x008000)
        case "B":
            self.option2Btn.backgroundColor = UIColor(rgb: 0x008000)
        case "C":
            self.option3Btn.backgroundColor = UIColor(rgb: 0x008000)
        case "D":
            self.option4Btn.backgroundColor = UIColor(rgb: 0x008000)
            
        default:
            break
    
        }
        
        switch selected  {
        case "A":
            self.option1Btn.backgroundColor = UIColor(rgb: 0xD50000)
        case "B":
            self.option2Btn.backgroundColor = UIColor(rgb: 0xD50000)
        case "C":
            self.option3Btn.backgroundColor = UIColor(rgb: 0xD50000)
        case "D":
            self.option4Btn.backgroundColor = UIColor(rgb: 0xD50000)
            
        
        default:
            break
        }
    }
        }
    
    @IBAction  func followClicked(_ sender: UIButton) {
        let request = ComplaintFollowRequest(follow_id: "\(sender.tag)", user_id: User.shared.userID)
        let resource = HomeResource()
        resource.followComplaint(request: request) { result in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let data):
                    if data == true && data != nil  {
                        self.followBtn.setTitle("Following", for: .normal)
                    } else {
                        self.followBtn.setTitle("Follow", for: .normal)
                    }
                    
                case .failure(_):
                    print("")
                }
              
            }
            
        }
    }
   
}
