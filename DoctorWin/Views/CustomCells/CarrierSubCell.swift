//
//  CarrierSubCell.swift
//  DoctorWin
//
//  Created by N517325 on 24/10/21.
//

import UIKit

class CarrierSubCell: UITableViewCell {

    @IBOutlet weak var postedDate: UILabel!
    @IBOutlet weak var hospitalImage: UIImageView!
    @IBOutlet weak var experience: UILabel!
    @IBOutlet weak var salary: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var specialityName: UILabel!
    @IBOutlet weak var hospitalName: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var bookMarkImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        hospitalImage.setCornerRadius(radius: 15)
        bgView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor(rgb: 0xE6E6E6), borderWidth: 0.5)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func chatClicked(_ sender: Any) {
    }
    
    @IBAction func callClicked(_ sender: Any) {
    }
    @IBAction func saveClicked(_ sender: UIButton) {
        let request = JobApplyRequest(user_id: User.shared.userID, job_id: "\(sender.tag)")
        let resource = JobsResource()
        resource.saveJob(request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success( let data):
                    if data.status {
                        self.bookMarkImage.image = UIImage(named: "fmark")
                    }
                    else {
                        self.bookMarkImage.image = UIImage(named: "mark")
                    }
                case .failure: break
                   //debug
                }
            }
           
        }
        
    }
    func configureCell(with data: JobsDataModel) {
        self.hospitalName.text =  data.designation! + " in " + data.companyName!
        self.specialityName.text = data.course
        self.location.text = data.location
        if let exp = data.experince {
            self.experience.text = "\(exp)" + " yrs Experience"

        }
        save.tag = data.id ?? 0
        if let salary = data.salary {
            self.salary.text = "\(salary) /" + data.salaryType!
        }

        if let urlString = data.image {
            let finalUrlString = ApiEndpoints.baseImageURL + urlString
            
            self.hospitalImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
        }
        if let date = data.date {
       let days = calculateDaysfrom(date: date)
            self.postedDate.text = "\(days)d ago"
        }
        if data.bookmarkStatus ?? false {
            self.bookMarkImage.image = UIImage(named: "fstar")
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
