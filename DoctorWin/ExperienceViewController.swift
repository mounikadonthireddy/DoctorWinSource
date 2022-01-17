//
//  ExperienceViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 03/01/22.
//

import UIKit

class ExperienceViewController: ViewController {
    
    @IBOutlet weak var hospitalNameTF: UITextField!
    @IBOutlet weak var designationTF: UITextField!
    @IBOutlet weak var departmentTf: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var toTF: UITextField!
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var current: UISwitch!
    @IBOutlet weak var save: UIButton!
    var expModel: ExperienceModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (expModel != nil) {
            hospitalNameTF.text = expModel?.hospital_name
            designationTF.text = expModel?.designation
            departmentTf.text = expModel?.department
            cityTF.text = expModel?.city
            fromTF.text = expModel?.start_date
            toTF.text = expModel?.end_date
            
        }
        hospitalNameTF.setUnderLine()
        hospitalNameTF.delegate = self
        designationTF.delegate = self
        departmentTf.delegate = self
        cityTF.delegate = self
        
        designationTF.setUnderLine()
        departmentTf.setUnderLine()
        cityTF.setUnderLine()
        fromTF.setUnderLine()
        toTF.setUnderLine()
        fromTF.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
        toTF.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed1))
        // Do any additional setup after loading the view.
    }
    
    @objc func doneButtonPressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let  datePicker = self.fromTF.inputView as? UIDatePicker {
            self.fromTF.text = dateFormatter.string(from: datePicker.date)
        }
        self.fromTF.resignFirstResponder()
        
    }
    @objc func doneButtonPressed1() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let  datePicker = self.toTF.inputView as? UIDatePicker {
            self.toTF.text = dateFormatter.string(from: datePicker.date)
        }
        
        self.toTF.resignFirstResponder()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tabBarController?.tabBar.isHidden = true
        
    }
    
    @IBAction func saveClicked(_ sender: UIButton) {
        self.showLoader()
        var todate = ""
        if toTF.text == "Present" {
            todate = fromTF.text ?? ""
        } else {
            todate = toTF.text ?? ""
        }
        
        let addModel = AddExperienceModel(hospital_name: hospitalNameTF.text ?? "avc", designation: designationTF.text ?? "aa", department: departmentTf.text ?? "aa", city: cityTF.text ?? "aa", start_date: fromTF.text ?? "2021-10-12", end_date: todate)
        
        let editResource = ProfileEditResource()
        editResource.editExperince(userID: User.shared.userID, expId: expModel?.id ?? 0, profileReq: addModel) { response in
            
            DispatchQueue.main.async {
                self.dismiss()
                if response != nil {
                    let alert = UIAlertController(title: nil, message: " Successfully Updated", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: Constants.OkAlertTitle, style: .default, handler: nil))
                    
                    self.present(alert, animated: true)
                }
                
            }
        }
    }
    
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension ExperienceViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

