//
//  CaseDetailsCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 20/04/22.
//

import UIKit

class CaseDetailsCell: UITableViewCell {

    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var postedDate: UILabel!
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

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        personImage.setCornerRadius(radius: <#T##Float#>)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
   
    func configureCellWith(data: HomeDataModel) {
        
//        personName.text = data.caseName
//        postedDate.text = data.postedData
//        postTitle.text = data.title
//        postDescription.text = data.complaint
//        presentIllness.text = data.presentIllness
//        pastIllness.text = data.pastIllness
//        drugsIllness.text = data.drugIllness
//        personalIllness.text = data.personalIllness
//        familyIllness.text = data.familyIllness
//        physicalExamination.text = data.physicalExamination
//        systemExamination.text = data.systemExamination
//        localExamination.text = data.localExamination
//        labInvestigation.text = data.labInvestigation
//        vitalInvestigation.text = data.vitusInvestigation
//        ImageInvestigation.text = data.imageInvestigation
//        diagnosiscResult.text = data.diagnosResult
//
//        if let urlString = data.postedImage {
//            let finalUrlString = "http://3.132.212.116:8000" + urlString
//
//            self.postImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
//        }
//
//        if let urlString = data.caseProfileImage {
//            let finalUrlString = "http://3.132.212.116:8000" + urlString
//
//            self.postImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
//        }
    }
    
    
}
