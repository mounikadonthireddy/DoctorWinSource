//
//  EditMeViewController.swift
//  DoctorWin
//
//  Created by N517325 on 15/11/21.
//

import UIKit

class EditMeViewController: ViewController {
    @IBOutlet weak var profileTableView: UITableView!
    var profileDataModel : ProfileDataModel!
    var personalDropDownData : ProfileEditDropDownModel!
    var professionalData : ProfessionalDropDownModel!
    var personalEditVM = ProfileEditViewModel()
    var spealityArray: [SpeciltyModel] = []
    var qualificationArray: [QualificationModel] = []
    var selectedIndex = 0
    @IBOutlet weak var imageView : UIImageView!
    var imageFileName: String = ""
    var fileType: String = ""
    var imagePicker: ImagePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)

        profileTableView.register(UINib(nibName: "MySelfCell", bundle: nil), forCellReuseIdentifier: "MySelfCell")
        profileTableView.register(UINib(nibName: "ProfileImageCell", bundle: nil), forCellReuseIdentifier: "ProfileImageCell")
        
        profileTableView.register(UINib(nibName: "EditPersonalInfoCell", bundle: nil), forCellReuseIdentifier: "EditPersonalInfoCell")
        personalEditVM.delegate = self
        
        profileTableView.register(UINib(nibName: "EditProfessionalDetailsCell", bundle: nil), forCellReuseIdentifier: "EditProfessionalDetailsCell")
        
        profileTableView.register(UINib(nibName: "AddExperienceCell", bundle: nil), forCellReuseIdentifier: "AddExperienceCell")
        
        profileTableView.register(UINib(nibName: "EditSkillCell", bundle: nil), forCellReuseIdentifier: "EditSkillCell")
        
        self.navigationController?.isNavigationBarHidden = true
        profileTableView.contentInset = UIEdgeInsets(top: -10, left: 0, bottom: 0, right: 0)
        
        
        loadLanguageDropGenderData()
        loadProfessionalDropDownData()
        downloadQualificationResource()
        downloadSpeacilityResource()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
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
    func downloadQualificationResource() {
        self.showLoader()
        let resouce = DropDownResource()
        resouce.getQualificationData { result in
            DispatchQueue.main.async {
                self.dismiss()
                self.qualificationArray = result
                self.profileTableView.reloadData()
            }
        }
    }
    func downloadSpeacilityResource() {
        self.showLoader()
        let resouce = DropDownResource()
        resouce.getSpecilityData { result in
            DispatchQueue.main.async {
                self.dismiss()
                self.spealityArray = result
                self.profileTableView.reloadData()
            }

        }
    }
    @IBAction func backClikced(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension EditMeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell: ProfileImageCell = tableView.dequeueReusableCell(withIdentifier: "ProfileImageCell", for: indexPath) as! ProfileImageCell
            // cell.configurePersonalEditCell(data: profileDataModel)
            cell.saveBtn.addTarget(self, action: #selector(imageUpload(button:)), for: .touchUpInside)
            cell.addImage.addTarget(self, action: #selector(selectImage(button:)), for: .touchUpInside)
            if self.imageView.image != nil {
                cell.profileImage.image =  self.imageView.image
            }
            cell.cellConfigureWith(data: profileDataModel)
            return cell
        case 1:
            switch selectedIndex {
            case 1:
                let cell: MySelfCell = tableView.dequeueReusableCell(withIdentifier: "MySelfCell", for: indexPath) as! MySelfCell
                cell.locationTF.delegate = self
                cell.nameTF.delegate = self
                cell.configurePersonalEditCell(data: profileDataModel)
                cell.profileDelegate = self
                cell.specilityTF.optionArray = spealityArray.map({ data in
                    return data.department
                })
                cell.qualificationTF.optionArray = qualificationArray.map({ data in
                    return data.qualification
                })
                return cell
            case 3:
                let cell: EditPersonalInfoCell = tableView.dequeueReusableCell(withIdentifier: "EditPersonalInfoCell", for: indexPath) as! EditPersonalInfoCell
                cell.genderTF.delegate = self
                cell.emailIDTF.delegate = self
                cell.dobTF.delegate = self
                cell.contactNumTF.delegate = self
                if personalDropDownData != nil {
                    cell.languageArray = personalDropDownData.language
                    cell.genderArray = personalDropDownData.gender
                    
                }
                cell.profileDelegate = self
                cell.configurePersonalEditCell(data: profileDataModel)
                
                
                return cell
            case 4:
                let cell: EditProfessionalDetailsCell = tableView.dequeueReusableCell(withIdentifier: "EditProfessionalDetailsCell", for: indexPath) as! EditProfessionalDetailsCell
                cell.configureCellWithProfessionData(data: profileDataModel)
                if professionalData != nil {
                    cell.configureDataForDropDown(data: professionalData)
                }
                cell.profileDelegate = self
                cell.instititeTF.delegate = self
                return cell
                
            case 5:
                let cell: AddExperienceCell = tableView.dequeueReusableCell(withIdentifier: "AddExperienceCell", for: indexPath) as! AddExperienceCell
                
                cell.profileDelegate = self
                return cell
                
            case 2,6:
                let cell: EditSkillCell = tableView.dequeueReusableCell(withIdentifier: "EditSkillCell", for: indexPath) as! EditSkillCell
                cell.configureCellWithEdit(data: profileDataModel, section: indexPath.section)
                cell.profileDelegate = self
                cell.detailsTF.delegate = self
                return cell
                
                
            default:
                
                return UITableViewCell()
                
            }
        default:
            
            return UITableViewCell()
            
            }
            
    }
    @objc func editClicked(button: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "EditMeViewController") as! EditMeViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func selectImage(button: UIButton) {
        self.imagePicker.present(from: button)
    }
    @objc func imageUpload(button: Any) {
        let param = [:] as [String : Any]
        self.showLoader()
        let url = ApiEndpoints.baseUrl + ApiEndpoints.profileEdit + "?user_id=\(User.shared.userID)"

        HttpUtility().profileUpload(img: self.imageView.image!, url: url, imageName: self.imageFileName, imageUploadName: "profileImage", param: param) { res in
            DispatchQueue.main.async {
                self.dismiss()
                print(res)
               // self.showAlertView(message: "News Posted Successfully")
                
            }
            
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 198
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
extension EditMeViewController: ProfileUpdateDelegate {
    func didProfileUpdated(status: Bool, error: String?) {
        let alert = UIAlertController(title: nil, message: "Profile Updated Successfully", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: Constants.OkAlertTitle, style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    
}
extension EditMeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

extension EditMeViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?, fileName: String?, fileType: String?) {
        self.imageView.image = image
        self.imageFileName = fileName ?? ""
        self.fileType = fileType ?? ""
        self.profileTableView.reloadData()
    }
    
}
