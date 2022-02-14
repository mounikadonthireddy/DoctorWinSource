//
//  MeViewController.swift
//  DoctorWin
//
//  Created by N517325 on 22/10/21.
//

import UIKit

class MeViewController: ViewController {
    @IBOutlet weak var profileTableView: UITableView!
    var profileDataModel : ProfileDataModel!
    var profileVM = ProfileViewModel()
    var experienceArray: [ExperienceModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        profileTableView.register(UINib(nibName: "ProfileNameCell", bundle: nil), forCellReuseIdentifier: "ProfileNameCell")
        profileTableView.register(UINib(nibName: "InfoCell", bundle: nil), forCellReuseIdentifier: "InfoCell")
        profileTableView.register(UINib(nibName: "ProfileSummaryCell", bundle: nil), forCellReuseIdentifier: "ProfileSummaryCell")
        profileTableView.register(UINib(nibName: "ProfileBasicDetailsCell", bundle: nil), forCellReuseIdentifier: "ProfileBasicDetailsCell")
        
        profileTableView.register(UINib(nibName: "ProfessionalDetailsCell", bundle: nil), forCellReuseIdentifier: "ProfessionalDetailsCell")
        
        profileTableView.contentInset = UIEdgeInsets.zero
        
        profileTableView.register(UINib(nibName: "ProfileDashboardCell", bundle: nil), forCellReuseIdentifier: "ProfileDashboardCell")
        
        profileTableView.register(UINib(nibName: "AddSkillsCell", bundle: nil), forCellReuseIdentifier: "AddSkillsCell")
        profileTableView.register(UINib(nibName: "ExperienceCell", bundle: nil), forCellReuseIdentifier: "ExperienceCell")
        
        profileTableView.register(UINib(nibName: "ExperienceAddCell", bundle: nil), forCellReuseIdentifier: "ExperienceAddCell")
        profileTableView.register(UINib(nibName: "ExperinceTitleCell", bundle: nil), forCellReuseIdentifier: "ExperinceTitleCell")
        profileTableView.register(UINib(nibName: "ProfileSkillsCell", bundle: nil), forCellReuseIdentifier: "ProfileSkillsCell")
        
        
        self.navigationController?.isNavigationBarHidden = true
        profileTableView.contentInset = UIEdgeInsets(top: -10, left: 0, bottom: 0, right: 0)
        profileVM.delegate = self
        
        
        self.profileTableView.delegate = self
        self.profileTableView.dataSource = self
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        parse()
        tabBarController?.tabBar.isHidden = false
    }
    func parse() {
        self.showLoader()
        profileVM.getProfileData(userID: User.shared.userID)
        
    }
    func loadExperince() {
        self.showLoader()
        profileVM.getProfileExperienceData(userID: User.shared.userID)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        //  tabBarController?.tabBar.isHidden = true
    }
}

extension MeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if profileDataModel != nil {
            if section == 6 {
                return experienceArray.count
            }
            return 1
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell: ProfileNameCell = tableView.dequeueReusableCell(withIdentifier: "ProfileNameCell", for: indexPath) as! ProfileNameCell
            cell.editBtn.addTarget(self, action: #selector(editClicked(button:)), for: .touchUpInside)

            cell.cellConfigureWith(data: profileDataModel)
            
            return cell
            
        case 1:
            let cell: ProfileDashboardCell = tableView.dequeueReusableCell(withIdentifier: "ProfileDashboardCell", for: indexPath) as! ProfileDashboardCell
            cell.casesCountBtn.addTarget(self, action: #selector(casesClicked(button:)), for: .touchUpInside)
            cell.appliedCountBtn.addTarget(self, action: #selector(appliedClicked(button:)), for: .touchUpInside)
            cell.newsCountBtn.addTarget(self, action: #selector(newsClicked(button:)), for: .touchUpInside)
            cell.articalsCountBtn.addTarget(self, action: #selector(articalsClicked(button:)), for: .touchUpInside)
            cell.storiesCountBtn.addTarget(self, action: #selector(storiesClicked(button:)), for: .touchUpInside)
            cell.pollsCountBtn.addTarget(self, action: #selector(pollsClicked(button:)), for: .touchUpInside)
            cell.followCountBtn.addTarget(self, action: #selector(followClicked(button:)), for: .touchUpInside)
            cell.followingCountBtn.addTarget(self, action: #selector(followClicked(button:)), for: .touchUpInside)
            
            cell.cellConfigureWith(data: profileDataModel)
            
            return cell
            
        case 2:
            let cell: ProfileSummaryCell = tableView.dequeueReusableCell(withIdentifier: "ProfileSummaryCell", for: indexPath) as! ProfileSummaryCell
            cell.cellConfigureWith(data: profileDataModel)
            cell.editBtn.addTarget(self, action: #selector(editClicked(button:)), for: .touchUpInside)

            
            return cell
            
        case 3:
            let cell: ProfileBasicDetailsCell = tableView.dequeueReusableCell(withIdentifier: "ProfileBasicDetailsCell", for: indexPath) as! ProfileBasicDetailsCell
            cell.cellConfigureWith(data: profileDataModel)
            cell.professionalEdit.addTarget(self, action: #selector(editClicked(button:)), for: .touchUpInside)

            
            return cell
        case 4:
            let cell: ProfessionalDetailsCell = tableView.dequeueReusableCell(withIdentifier: "ProfessionalDetailsCell", for: indexPath) as! ProfessionalDetailsCell
            cell.cellConfigureWith(data: profileDataModel)
            cell.professionalEdit.addTarget(self, action: #selector(editClicked(button:)), for: .touchUpInside)

            
            return cell
            
        case 5:
            let cell: ExperinceTitleCell = tableView.dequeueReusableCell(withIdentifier: "ExperinceTitleCell", for: indexPath) as! ExperinceTitleCell
            
            return cell
            
        case 6:
            let cell: ExperienceCell = tableView.dequeueReusableCell(withIdentifier: "ExperienceCell", for: indexPath) as! ExperienceCell
            cell.configureCell(data: experienceArray[indexPath.row])
            cell.edit.addTarget(self, action: #selector(expEditClicked(button:)), for: .touchUpInside)
            cell.edit.tag = indexPath.row
            cell.delete.tag = indexPath.row
            cell.delete.addTarget(self, action: #selector(deleteClicked(button:)), for: .touchUpInside)
            cell.edit.addTarget(self, action: #selector(editClicked(button:)), for: .touchUpInside)

            return cell
            
        case 7:
            let cell: ProfileSkillsCell = tableView.dequeueReusableCell(withIdentifier: "ProfileSkillsCell", for: indexPath) as! ProfileSkillsCell
            cell.cellConfigureWith(data: profileDataModel)
            cell.edit.addTarget(self, action: #selector(editClicked(button:)), for: .touchUpInside)

            return cell
            
            
        default:
            
            return UITableViewCell()
            
        }
    }
    @objc func editClicked(button: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "EditMeViewController") as! EditMeViewController
        nextVC.profileDataModel = profileDataModel
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func logoutClicked(button: Any) {
        let str = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func expEditClicked(button: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ExperienceViewController") as! ExperienceViewController
        nextVC.expModel = experienceArray[button.tag]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func casesClicked(button: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "MyCasesViewController") as! MyCasesViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func newsClicked(button: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "MyNewsViewController") as! MyNewsViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func storiesClicked(button: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "MyStoriesViewController") as! MyStoriesViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func articalsClicked(button: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "MyArticalViewController") as! MyArticalViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func pollsClicked(button: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "MyPollsViewController") as! MyPollsViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    @objc func appliedClicked(button: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "AppliedJobViewController") as! AppliedJobViewController
        //        nextVC.expModel = experienceArray[button.tag]
        nextVC.showBack = true
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func followClicked(button: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "FollowViewController") as! FollowViewController
        //        nextVC.expModel = experienceArray[button.tag]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func deleteClicked(button: UIButton) {
        self.showLoader()
        let req = DeleteExpModel(exp_id: experienceArray[button.tag].id, user_id: Int(User.shared.userID)!)
        profileVM.deleteExp(userID: User.shared.userID, expID: experienceArray[button.tag].id, request: req) { result in
            DispatchQueue.main.async {
                self.dismiss()
                if result?.status ?? false {
                    let alert = UIAlertController(title: nil, message: "Deleted Successfully", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: Constants.OkAlertTitle, style: .default, handler: nil))
                    
                    self.present(alert, animated: true)
                    self.loadExperince()
                }
            }
        }
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return CGFloat.leastNormalMagnitude
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
}
extension MeViewController: ProfileViewModelDelegate {
   
    func didReciveProfileExperienceData(response: [ExperienceModel]?, error: String?) {
        self.dismiss()
        experienceArray = response ?? []
        profileTableView.reloadData()
    }
    
    
    func didReciveProfileData(response: ProfileDataModel?, error: String?) {
        self.dismiss()
        profileDataModel = response
        profileTableView.reloadData()
        self.loadExperince()
    }
    
    
}

struct ExperienceModel: Codable {
    let hospital_name: String?
    let designation: String?
    let department: String?
    let city: String?
    let start_date: String?
    let end_date: String?
    let id: Int
    
}
struct DeleteExpModel: Codable {
    let exp_id: Int
    let user_id: Int
}
