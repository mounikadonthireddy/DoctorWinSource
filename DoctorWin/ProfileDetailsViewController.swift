//
//  ProfileDetailsViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 11/01/22.
//

import UIKit

class ProfileDetailsViewController: ViewController {

    @IBOutlet weak var profileTableView: UITableView!
    var profileDataModel : ProfileDataModel!
    var profileVM = ProfileViewModel()
    var experienceArray: [ExperienceModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        profileTableView.register(UINib(nibName: "ProfileHeadCell", bundle: nil), forCellReuseIdentifier: "ProfileHeadCell")
        
        profileTableView.register(UINib(nibName: "InfoCell", bundle: nil), forCellReuseIdentifier: "InfoCell")
        profileTableView.register(UINib(nibName: "AddSkillsCell", bundle: nil), forCellReuseIdentifier: "AddSkillsCell")
        profileTableView.register(UINib(nibName: "ExperienceCell", bundle: nil), forCellReuseIdentifier: "ExperienceCell")
        
        profileTableView.register(UINib(nibName: "ExperienceAddCell", bundle: nil), forCellReuseIdentifier: "ExperienceAddCell")
        profileTableView.register(UINib(nibName: "ExperinceTitleCell", bundle: nil), forCellReuseIdentifier: "ExperinceTitleCell")
        
        
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

extension ProfileDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if profileDataModel != nil {
            if section == 4 {
                return experienceArray.count
            }
            return 1
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell: ProfileHeadCell = tableView.dequeueReusableCell(withIdentifier: "ProfileHeadCell", for: indexPath) as! ProfileHeadCell
            cell.cellConfigureWith(data: profileDataModel, section: indexPath.section)
            cell.followingBtn.addTarget(self, action: #selector(followClicked(button:)), for: .touchUpInside)
            cell.followersBtn.addTarget(self, action: #selector(followClicked(button:)), for: .touchUpInside)
            cell.logoutBtn.addTarget(self, action: #selector(logoutClicked(button:)), for: .touchUpInside)

            cell.casesBtn.addTarget(self, action: #selector(casesClicked(button:)), for: .touchUpInside)
            cell.newsBtn.addTarget(self, action: #selector(newsClicked(button:)), for: .touchUpInside)
            cell.appliedBtn.addTarget(self, action: #selector(appliedClicked(button:)), for: .touchUpInside)


            return cell
        case 2:
            let cell: InfoCell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as! InfoCell
            cell.cellConfigureWith(data: profileDataModel, section: indexPath.section)
            cell.personalEdit.addTarget(self, action: #selector(editClicked(button:)), for: .touchUpInside)
            cell.professionalEdit.addTarget(self, action: #selector(editClicked(button:)), for: .touchUpInside)
            
            return cell
            
        case 4:
            let cell: ExperienceCell = tableView.dequeueReusableCell(withIdentifier: "ExperienceCell", for: indexPath) as! ExperienceCell
            cell.configureCell(data: experienceArray[indexPath.row])
            cell.edit.addTarget(self, action: #selector(expEditClicked(button:)), for: .touchUpInside)
            cell.edit.tag = indexPath.row
            cell.delete.tag = indexPath.row
            cell.delete.addTarget(self, action: #selector(deleteClicked(button:)), for: .touchUpInside)
            
            return cell
        case 3:
            let cell: ExperinceTitleCell = tableView.dequeueReusableCell(withIdentifier: "ExperinceTitleCell", for: indexPath) as! ExperinceTitleCell
            
            return cell
        case 5:
            let cell: ExperienceAddCell = tableView.dequeueReusableCell(withIdentifier: "ExperienceAddCell", for: indexPath) as! ExperienceAddCell
            //            cell.cellConfigureWith(section: indexPath.section, data: profileDataModel)
            //            cell.edit.addTarget(self, action: #selector(editClicked(button:)), for: .touchUpInside)
            
            return cell
        case 1,6:
            let cell: AddSkillsCell = tableView.dequeueReusableCell(withIdentifier: "AddSkillsCell", for: indexPath) as! AddSkillsCell
            cell.cellConfigureWith(section: indexPath.section, data: profileDataModel)
            cell.edit.addTarget(self, action: #selector(editClicked(button:)), for: .touchUpInside)
            
            return cell
            
            
        default:
            
            return UITableViewCell()
            
        }
    }
    @objc func editClicked(button: Any) {
        let str = UIStoryboard(name: "Me", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "EditMeViewController") as! EditMeViewController
        nextVC.profileDataModel = profileDataModel
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func logoutClicked(button: Any) {
        let str = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func expEditClicked(button: UIButton) {
        let str = UIStoryboard(name: "Me", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "ExperienceViewController") as! ExperienceViewController
        nextVC.expModel = experienceArray[button.tag]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func casesClicked(button: UIButton) {
        let str = UIStoryboard(name: "Me", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "MyCasesViewController") as! MyCasesViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func newsClicked(button: UIButton) {
        let str = UIStoryboard(name: "Job", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "MyNewsViewController") as! MyNewsViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func appliedClicked(button: UIButton) {
        let str = UIStoryboard(name: "Job", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "AppliedJobViewController") as! AppliedJobViewController
//        nextVC.expModel = experienceArray[button.tag]
        nextVC.showBack = true
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func followClicked(button: UIButton) {
        let str = UIStoryboard(name: "Network", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "FollowViewController") as! FollowViewController
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
        if section == 4 {
            return 0
        } else if section == 5{
            return 2
        }
        return 10
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
}
extension ProfileDetailsViewController: ProfileViewModelDelegate {
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

