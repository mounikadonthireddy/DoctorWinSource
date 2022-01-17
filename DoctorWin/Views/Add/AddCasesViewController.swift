//
//  AddCasesViewController.swift
//  DoctorWin
//
//  Created by N517325 on 01/11/21.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields
class AddCasesViewController: UIViewController {
    @IBOutlet weak var caseTitle: UITextField!
    @IBOutlet weak var presentIllness: MDCOutlinedTextField!
    @IBOutlet weak var pastIllness: MDCOutlinedTextField!
    @IBOutlet weak var drugs: MDCOutlinedTextField!
    @IBOutlet weak var personal: MDCOutlinedTextField!
    @IBOutlet weak var family: MDCOutlinedTextField!
    @IBOutlet weak var physicalExamination: MDCOutlinedTextField!
    @IBOutlet weak var systemExamination: MDCOutlinedTextField!
    @IBOutlet weak var localExamination: MDCOutlinedTextField!
    @IBOutlet weak var vitus: MDCOutlinedTextField!
    @IBOutlet weak var labFinding: MDCOutlinedTextField!
    @IBOutlet weak var imaging: MDCOutlinedTextField!
    @IBOutlet weak var probableDiagnosis: MDCOutlinedTextField!
    @IBOutlet weak var chiefComplaint: MDCOutlinedTextField!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var imageFileName: String = ""
    var imagePicker: ImagePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)

        presentIllness.label.text = "Present Illness"
        pastIllness.label.text = "Past Illness"
        drugs.label.text = "Drugs"
        personal.label.text = "Personal"
        family.label.text = "Family"
        physicalExamination.label.text = "Physical Examination"
        systemExamination.label.text = "System Examination"
        localExamination.label.text = "Local Examination"
        
        vitus.label.text = "Vitus"
        labFinding.label.text = "Lab Finding"
        imaging.label.text = "Imaging"
        chiefComplaint.label.text = "Chief Complaint"
        
        probableDiagnosis.label.text = "Probable Diagnosis"
        
        //        presentIllness.placeholder = "555-555-5555"
        //        presentIllness.leadingAssistiveLabel.text = "This is helper text"
        //        presentIllness.sizeToFit()
        
    }
    
    @IBAction func submitClicked(_ sender: UIButton) {
        
//        if caseTitle.text == "" {
//            showAlertView(message: "Enter ")
//        } else {
                    
        let parm = ["com_title": caseTitle.text! , "chief_complaint": chiefComplaint.text!, "present_illness": presentIllness.text!, "past_illness": pastIllness.text!, "drugs": drugs.text! , "personal": personal.text! , "family": family.text! , "physical_exam": physicalExamination.text! , "system_exam": systemExamination.text! , "local_exam": localExamination.text! , "vitus": vitus.text! , "lab_finding": labFinding.text! , "imaging": imaging.text! , "diagnosis": probableDiagnosis.text! , "complaint_id": User.shared.userID]
            let url = ApiEndpoints.baseUrl + ApiEndpoints.addCase + "?user_id=\(User.shared.userID)"
            
            HttpUtility().profileUpload(img: imageView.image!, url: url, imageName: imageFileName, imageUploadName: "com_image", param: parm) { res in
                print(res)
            }
//        }
    }
    func showAlertView(message: String) {
        
    }
    @IBAction func addImageClicked(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
        
    }
}

extension AddCasesViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
extension AddCasesViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?, fileName: String?, fileType: String?) {
        self.imageView.image = image
        self.imageFileName = fileName ?? ""
//        self.fileType = fileType ?? ""
    }
    
}
