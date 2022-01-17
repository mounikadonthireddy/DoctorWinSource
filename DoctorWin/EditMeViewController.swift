//
//  EditMeViewController.swift
//  DoctorWin
//
//  Created by N517325 on 15/11/21.
//

import UIKit

class EditMeViewController: UIViewController {
    @IBOutlet weak var profileTableView: UITableView!
    var profileDataModel : ProfileDataModel!
    var personalDropDownData : ProfileEditDropDownModel!
    var professionalData : ProfessionalDropDownModel!

    var personalEditVM = ProfileEditViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        profileTableView.register(UINib(nibName: "ProfileEditCell", bundle: nil), forCellReuseIdentifier: "ProfileEditCell")
        personalEditVM.delegate = self
        
        profileTableView.register(UINib(nibName: "ProfileProfessionalEditCell", bundle: nil), forCellReuseIdentifier: "ProfileProfessionalEditCell")
        
        profileTableView.register(UINib(nibName: "AddExperienceCell", bundle: nil), forCellReuseIdentifier: "AddExperienceCell")
        
        profileTableView.register(UINib(nibName: "EditSkillCell", bundle: nil), forCellReuseIdentifier: "EditSkillCell")

        self.navigationController?.isNavigationBarHidden = true
        profileTableView.contentInset = UIEdgeInsets(top: -10, left: 0, bottom: 0, right: 0)

      
        loadLanguageDropGenderData()
        loadProfessionalDropDownData()
    }
  
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tabBarController?.tabBar.isHidden = true

    }

    func loadLanguageDropGenderData() {
        
        personalEditVM.getLanguageAndGenderDropDownData(userID: User.shared.userID)
    }
    func loadProfessionalDropDownData() {
        
        personalEditVM.getProfessionalDropDownData(userID: User.shared.userID)
    }
    @IBAction func backClikced(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
 
}

extension EditMeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
       
        case 1:
            let cell: ProfileEditCell = tableView.dequeueReusableCell(withIdentifier: "ProfileEditCell", for: indexPath) as! ProfileEditCell
            if personalDropDownData != nil {
            cell.languageArray = personalDropDownData.language
            cell.genderArray = personalDropDownData.gender
                
            }
            cell.profileDelegate = self
            cell.configurePersonalEditCell(data: profileDataModel)
            

            return cell
        case 2:
            let cell: ProfileProfessionalEditCell = tableView.dequeueReusableCell(withIdentifier: "ProfileProfessionalEditCell", for: indexPath) as! ProfileProfessionalEditCell
            cell.configureCellWithProfessionData(data: profileDataModel)
            if professionalData != nil {
                cell.configureDataForDropDown(data: professionalData)
            }
            cell.profileDelegate = self

            return cell
            
        case 3:
            let cell: AddExperienceCell = tableView.dequeueReusableCell(withIdentifier: "AddExperienceCell", for: indexPath) as! AddExperienceCell
           
            cell.profileDelegate = self
            return cell
            
        case 0,4:
            let cell: EditSkillCell = tableView.dequeueReusableCell(withIdentifier: "EditSkillCell", for: indexPath) as! EditSkillCell
            cell.configureCellWithEdit(data: profileDataModel, section: indexPath.section)
            cell.profileDelegate = self
            return cell
            
            
        default:
        
            return UITableViewCell()
           
        }
    }
  @objc func editClicked(button: Any) {
    let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "EditMeViewController") as! EditMeViewController
    self.navigationController?.pushViewController(nextVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       
            return 0
       
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 360
        } else if indexPath.section == 2  {
            return 350
        } else {
            return UITableView.automaticDimension
        }
    }
}
extension EditMeViewController: ProfileEditViewModelDelegate {
    func didProfessionalData(response: ProfessionalDropDownModel?, error: String?) {
        professionalData = response
        profileTableView.reloadData()
    }
    
    func didReceiveTopJobs(response: ProfileEditDropDownModel?, error: String?) {
        personalDropDownData = response
        profileTableView.reloadData()
        
    }
    
    
}
extension EditMeViewController: ProfileUpdateDeleegate {
    func didProfileUpdated(status: Bool, error: String?) {
        let alert = UIAlertController(title: nil, message: "Profile Updated Successfully", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: Constants.OkAlertTitle, style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    
}
