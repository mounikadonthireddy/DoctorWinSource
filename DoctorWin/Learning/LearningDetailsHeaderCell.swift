//
//  LearningDetailsHeaderCell.swift
//  DoctorWin
//
//  Created by AHP on 13/10/2565 BE.
//

import UIKit

class LearningDetailsHeaderCell: UITableViewCell {
    @IBOutlet weak var courseImage: UIImageView!
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var preview: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var cart: UIButton!
    @IBOutlet weak var postedName: UIButton!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var departmentLbl: UILabel!
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["OverView", "Curriculm", "Buy"])
            interfaceSegmented.selectorViewColor = .blue
            interfaceSegmented.selectorTextColor = .blue
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        preview.setCornerRadius(radius: Float(preview.frame.height)/2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(data: CourseDetailsModel) {
        courseName.text = data.subject_title ?? ""
        postedName.setTitle(data.lecture_creater_name ?? "", for: .normal)
     //   courseVidoes.text = "\(data.number_of_lession ?? 0)"
        rating.text = "(" +  "\(data.rating ?? "")" + ")"
        departmentLbl.text = data.department ?? ""
        if let urlString = data.image {
            self.courseImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }
}
