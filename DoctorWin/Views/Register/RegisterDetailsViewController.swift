//
//  RegisterDetailsViewController.swift
//  DoctorWin
//
//  Created by N517325 on 04/11/21.
//

import UIKit
import iOSDropDown
class RegisterDetailsViewController: UIViewController {
    @IBOutlet weak var contactTF: PaddingTextFeild!
    @IBOutlet weak var emailID: PaddingTextFeild!
    @IBOutlet weak var gender: DropDown!
    @IBOutlet weak var dobTF: PaddingTextFeild!
    @IBOutlet weak var locationTF: PaddingTextFeild!
    @IBOutlet weak var languageTF: DropDown!
    @IBOutlet weak var workingTF: DropDown!
    @IBOutlet weak var instituteTF: PaddingTextFeild!
    @IBOutlet weak var graduationTF: DropDown!
    @IBOutlet weak var gradInsitituteTF: DropDown!
    @IBOutlet weak var postGradeTF: DropDown!
    @IBOutlet weak var postGradeInstituteTF: DropDown!
    @IBOutlet weak var skills: PaddingTextFeild!
    @IBOutlet weak var aboutMe: PaddingTextFeild!
    @IBOutlet weak var addPhoto: UIButton!
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var addExp: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var personalDropDownData : ProfileEditDropDownModel!
    var professionalData : ProfessionalDropDownModel!
    let group = DispatchGroup()
    var personalEditVM = ProfileEditViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        personalEditVM.delegate = self
        self.loadLanguageDropGenderData()
        self.loadProfessionalDropDownData()
        
        dobTF.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterDetailsViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterDetailsViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func doneButtonPressed() {
        if let  datePicker = self.dobTF.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.dobTF.text = dateFormatter.string(from: datePicker.date)
        }
        self.dobTF.resignFirstResponder()
    }
    
    @IBAction func skipClicked(_ sender: Any) {
        let str = UIStoryboard(name: "Home", bundle: nil)
        let nextViewController = str.instantiateViewController(withIdentifier: "tabbar")
        
        nextViewController.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func addPhotoClicked(_ sender: Any) {
        
    }
    @IBAction func submitClicked(_ sender: Any) {
        self.uploadPersonalData()
    }
    @IBAction func addExpClicked(_ sender: Any) {
        let str = UIStoryboard(name: "Home", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "ExperienceViewController") as! ExperienceViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func uploadPersonalData() {
        if contactTF.text != "" || emailID.text != "" || gender.text != "" || dobTF.text != "" || locationTF.text != "" || languageTF.text != "" {
            let name = UserDefaults.standard.value(forKey: "username") ?? ""
            
            let personalInfoRequest = PersonalInfoEditModel1(phone_number: contactTF.text ?? "", email: self.emailID.text ?? "", gender: gender.text ?? "", dob: dobTF.text ?? "", location: locationTF.text ?? "", language: languageTF.text ?? "", profile_name: name as! String)
            let resource = ProfileEditResource()
            resource.editProfilePersonalInfoData(userID: User.shared.userID, profileReq: personalInfoRequest) { data in
                DispatchQueue.main.async {
                    self.uploadProfessionalDetails()
                }
            }
        }
        
    }
    func uploadProfessionalDetails() {
        let editModel = ProfessionalEditModel(current_department: workingTF.text ?? "", current_institute: instituteTF.text ?? "", ug: graduationTF.text ?? "", ug_institute_name: self.gradInsitituteTF.text ?? "", pg: postGradeTF.text ?? "", pg_institute_name: postGradeInstituteTF.text ?? "")
        
        let resource = ProfileEditResource()
        resource.editProfileProfessionalInfoData(userID: User.shared.userID, profileReq: editModel) { data1 in
            DispatchQueue.main.async {
                self.uploadAboutdata()
            }
            
        }
        
    }
    
    
    func addExperienceData() {
        let addModel = AddExperienceModel(hospital_name: "avc", designation:  "aa", department: "aa", city:  "aa", start_date:  "2021-10-12", end_date:  "2022-10-12")
        
        let editResource = ProfileEditResource()
        editResource.addExperience(userID: "75", profileReq: addModel) { response in
            
        }
        
    }
    func uploadAboutdata() {
        let editModel = EditAboutModel(tell_me_about_youself: aboutMe.text ?? "dfsad")
        let resource = ProfileEditResource()
        resource.registerProfileAboutMe(userID: User.shared.userID, profileReq: editModel) { res in
            DispatchQueue.main.async {
                self.uploadSkillsdata()
            }
        }
    }
    func uploadSkillsdata() {
        let editModel = EditSkillModel(skill: skills.text ?? "sfzxfddgvf")
        let resource = ProfileEditResource()
        resource.registerProfileSkill(userID: User.shared.userID, profileReq: editModel) { res in
            DispatchQueue.main.async {
                let str = UIStoryboard(name: "Home", bundle: nil)
                let nextViewController = str.instantiateViewController(withIdentifier: "tabbar")
                
                nextViewController.navigationController?.isNavigationBarHidden = true
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
    }
    func loadLanguageDropGenderData() {
        
        personalEditVM.getLanguageAndGenderDropDownData(userID: User.shared.userID)
        
    }
    func loadProfessionalDropDownData() {
        
        personalEditVM.getProfessionalDropDownData(userID: User.shared.userID)
        
    }
}



extension RegisterDetailsViewController: ProfileEditViewModelDelegate {
    func didProfessionalData(response: ProfessionalDropDownModel?, error: String?) {
        graduationTF.optionArray = response?.ug_course ?? []
        if response?.ug_course.count ?? 0 > 0 {
            graduationTF.text = response?.ug_course[0]
        }
        workingTF.optionArray = response?.department ?? []
        
        if response?.department.count ?? 0 > 0 {
            workingTF.text = response?.department[0]
        }
        postGradeTF.optionArray = response?.pg_course ?? []
        if response?.pg_course.count ?? 0 > 0 {
            postGradeTF.text = response?.pg_course[0]
        }
        postGradeInstituteTF.optionArray = response?.pg_institute ?? []
        if response?.pg_institute.count ?? 0 > 0 {
            postGradeInstituteTF.text = response?.pg_institute[0]
        }
        gradInsitituteTF.optionArray = response?.ug_institute ?? []
        
        if response?.ug_institute.count ?? 0 > 0 {
            gradInsitituteTF.text = response?.ug_institute[0]
        }
    }
    
    func didReceiveTopJobs(response: ProfileEditDropDownModel?, error: String?) {
        languageTF.optionArray = response?.language ?? []
        if response?.language.count ?? 0 > 0 {
            languageTF.text = response?.language[0]
        }
        
        gender.optionArray = response?.gender ?? []
        if response?.gender.count ?? 0 > 0 {
            gender.text = response?.gender[0]
        }
        
    }
    
    
}
extension RegisterDetailsViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return textView.resignFirstResponder()
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        
        // reset back the content inset to zero after keyboard is gone
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}

