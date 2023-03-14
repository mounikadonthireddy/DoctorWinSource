//
//  CaseDetailsCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 20/04/22.
//

import UIKit

class CaseDetailsCell: UITableViewCell {

    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postDescription: UILabel!
    @IBOutlet weak var presentIllness: UILabel!
    @IBOutlet weak var pastIllness: UILabel!
    @IBOutlet weak var drugsIllness: UILabel!
    @IBOutlet weak var personalIllness: UILabel!
    @IBOutlet weak var familyIllness: UILabel!
    @IBOutlet weak var physicalExamination: UILabel!
    @IBOutlet weak var systemExamination: UILabel!
    @IBOutlet weak var localExamination: UILabel!
    @IBOutlet weak var vitalInvestigation: UILabel!
    @IBOutlet weak var labInvestigation: UILabel!
    @IBOutlet weak var ImageInvestigation: UILabel!
    @IBOutlet weak var diagnosiscResult: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var imageHeiht: NSLayoutConstraint!
    @IBOutlet weak var pageControl: UIPageControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        personImage.setCornerRadiusWithBorderColor(radius: 25, color: UIColor.lightGray, borderWidth: 0.2)
//        personImage.setCornerRadius(radius: <#T##Float#>)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
   
    func configureCellWith(data: CaseDetailsModel) {
        
        personName.text = data.userDetails?.name ?? ""
//        postedDate.text = data.postedData
        postTitle.text = data.title
        postDescription.text = data.description
        presentIllness.text = data.present_illness
        pastIllness.text = data.past_illness
        drugsIllness.text = data.drugs
        personalIllness.text = data.personal
        familyIllness.text = data.family
        physicalExamination.text = data.physical_exam
        systemExamination.text = data.system_exam
        localExamination.text = data.local_exam
        labInvestigation.text = data.lab_finding
        vitalInvestigation.text = data.vitus
        ImageInvestigation.text = data.imaging
        diagnosiscResult.text = data.diagnosis

        if let urlString = data.userDetails?.image {
            let finalUrlString =  urlString

            self.personImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
        }

        if let imageData = data.image {
            pageControl.numberOfPages = imageData.count
            if imageData.count > 0 {
                pageControl.isHidden = false
                self.imageHeiht.constant = 350
                if let urlString = imageData[0].image {
                    self.postImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
                }
            } else {
                imageHeiht.constant = 0
            }
        } else {
            imageHeiht.constant = 0
            pageControl.isHidden = true
        }
    }
    
    
}
