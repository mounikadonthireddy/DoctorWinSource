//
//  JobsCollectionCell.swift
//  DoctorWin
//
//  Created by N517325 on 29/10/21.
//

import UIKit

class JobsCollectionCell: UICollectionViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var postedDate: UILabel!
    @IBOutlet weak var hospitalImage: UIImageView!
    @IBOutlet weak var experience: UILabel!
    @IBOutlet weak var salary: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var specialityName: UILabel!
    @IBOutlet weak var hospitalName: UILabel!
    @IBOutlet weak var save: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.clipsToBounds = true
        self.bgView.layer.cornerRadius = 10
    
        self.bgView.layer.borderWidth = 0.5
        self.bgView.layer.borderColor = UIColor.lightGray.cgColor
        hospitalImage.setCornerRadius(radius: 10)
    }
    @IBAction func chatClicked(_ sender: UIButton) {
    }
    
    @IBAction func callClicked(_ sender: UIButton) {
        if let url = NSURL(string: "tel://630473236"),
           UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    @IBAction func saveClicked(_ sender: UIButton) {
        let request = JobApplyRequest(user_id: User.shared.userID, job_id: "\(sender.tag)")
        let resource = JobsResource()
        resource.saveJob(request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success( let data):
                    if data.status {
                        self.save.setImage( UIImage(named: "fmark"), for: .normal)
                    }
                    else {
                        self.save.setImage( UIImage(named: "mark"), for: .normal)
                    }
                case .failure: break
                   //debug
                }
            }
           
        }
        
    }
    func configureCell(with data: JobsDataModel) {
        self.hospitalName.text =  data.designation! + " in " + data.companyName!
        self.hospitalName.numberOfLines = 2
        self.hospitalName.lineBreakMode = .byWordWrapping
        self.specialityName.text = data.course
        self.location.text = data.location
        if let exp = data.experince {
            self.experience.text = "\(exp)" + "yrs Experience"
        }
        self.save.tag = data.id ?? 0
        
        
        if let salary = data.salary {
            self.salary.text = "\(salary) /" + data.salaryType!
        }
        if data.bookmarkStatus ?? false {
            //self.save.setImage(UIImage(named: "fstar"), for: .normal)
        } else {
            //self.save.setImage(UIImage(named: "star"), for: .normal)

        }

        if let urlString = data.image {
            let finalUrlString = ApiEndpoints.baseImageURL + urlString
            
            self.hospitalImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
            if let date = data.date {
           let days = calculateDaysfrom(date: date)
                self.postedDate.text = "\(days)d ago"
            }
        }
    }

func calculateDaysfrom(date: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS"
        let formatedStartDate = dateFormatter.date(from: date)
        let currentDate = Date()
        _ = Set<Calendar.Component>([ .day])
        let differenceOfDate =  Calendar.current.dateComponents([.day], from: formatedStartDate!, to: currentDate).day!
        return differenceOfDate
    }
}

struct JobApplyRequest: Codable {
    let user_id: String
    let job_id: String
}
