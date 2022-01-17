//
//  CreateCustomJobViewController.swift
//  DoctorWin
//
//  Created by N517325 on 04/11/21.
//

import UIKit
import iOSDropDown


class CreateCustomJobViewController: ViewController {
    @IBOutlet weak var departmentTF: DropDown!
    @IBOutlet weak var positionTF: DropDown!
    @IBOutlet weak var hospitalTypeTF: DropDown!
    @IBOutlet weak var cityTF: DropDown!
    @IBOutlet weak var salaryTF: DropDown!
    @IBOutlet weak var experienceTF: DropDown!
    @IBOutlet weak var jobTypeTF: DropDown!
    @IBOutlet weak var accomdationTF: DropDown!


    var customJobModel :CustomJobModel!
    var creatCustomJobVM = AddCustomJobViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        creatCustomJobVM.delegate = self
        parse1()
    }
    
    func parse1() {
        self.showLoader()
        creatCustomJobVM.getDropDownData(userID: User.shared.userID)
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        if departmentTF.text == "" ||  positionTF.text == "" ||  hospitalTypeTF.text == "" ||  cityTF.text == "" || salaryTF.text == "" || experienceTF.text == "" || jobTypeTF.text == "" || accomdationTF.text == "" {
            
        } else {
            
            let model = CreateCustomJobModel(user_id: User.shared.userID, department: departmentTF.text!, job_position: positionTF.text!, type_of_hospital: hospitalTypeTF.text!, location: cityTF.text!, minimum_salary: salaryTF.text!, work_expericence: experienceTF.text!, jobType: jobTypeTF.text!, allowance: accomdationTF.text!)
            
            creatCustomJobVM.postQuestion(request: model, userID: User.shared.userID)
            
        }
        
    }
    @IBAction func backCliced(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension CreateCustomJobViewController: AddCustomJobViewModelDelegate {
    func didReciveDropdownData(response: CustomJobModel?, error: String?) {
        self.dismiss()
        if error == nil {
            customJobModel = response
            departmentTF.optionArray = customJobModel.departmentArray ?? []
            positionTF.optionArray = customJobModel.positionArray ?? []
            hospitalTypeTF.optionArray = customJobModel.hospitalArray ?? []
            cityTF.optionArray = customJobModel.locationArray ?? []
            
            if  let array = customJobModel.salaryArray {
                salaryTF.optionArray  = array.compactMap { String($0)}
            }
            if  let exp = customJobModel.vacancyArray {
                experienceTF.optionArray  = exp.compactMap { String($0)}
            }
            jobTypeTF.optionArray = customJobModel.jobTypeArray ?? []
            accomdationTF.optionArray = ["Yes", "No"]
        }
    }
    
    
    func didPostCustomJob(status: Bool, error: String?) {
        print(status)
        self.navigationController?.popViewController(animated: true)
    }
}
struct CreateCustomJobModel: Codable {
    let user_id: String
    let department: String
    let job_position: String
    let type_of_hospital: String
    let location: String
    let minimum_salary: String
    let work_expericence: String
    let jobType: String
    let allowance: String

}
