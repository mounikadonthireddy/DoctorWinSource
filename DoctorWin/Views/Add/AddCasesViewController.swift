//
//  AddCasesViewController.swift
//  DoctorWin
//
//  Created by N517325 on 01/11/21.
//

import UIKit

class AddCasesViewController: UIViewController {
    @IBOutlet weak var caseTitle: UITextView!
    @IBOutlet weak var presentIllness: UITextField!
    @IBOutlet weak var pastIllness: UITextField!
    @IBOutlet weak var drugs: UITextField!
    @IBOutlet weak var personal: UITextField!
    @IBOutlet weak var family: UITextField!
    @IBOutlet weak var physicalExamination: UITextField!
    @IBOutlet weak var systemExamination: UITextField!
    @IBOutlet weak var localExamination: UITextField!
    @IBOutlet weak var vitus: UITextField!
    @IBOutlet weak var labFinding: UITextField!
    @IBOutlet weak var imaging: UITextField!
    @IBOutlet weak var probableDiagnosis: UITextField!
    @IBOutlet weak var chiefComplaint: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var patientViewHeight: NSLayoutConstraint!
    @IBOutlet weak var chiefViewHeight: NSLayoutConstraint!
    @IBOutlet weak var investigationViewHeight: NSLayoutConstraint!
    @IBOutlet weak var probableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var examinationViewHeight: NSLayoutConstraint!
    @IBOutlet weak var patientView: UIView!
    @IBOutlet weak var investigationView: UIView!
    @IBOutlet weak var examinationView: UIView!
    @IBOutlet weak var probableView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var historyAdd: UIButton!
    @IBOutlet weak var examAdd: UIButton!
    @IBOutlet weak var invigstAdd: UIButton!
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    var chiefEnabled = false
    var historyEnabled = false
    var examinationEnabled = false
    var invistigationEnabled = false
    var diagnosisEnabled = false
    var imageFileName: String = ""
    var imagePicker: ImagePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        patientViewHeight.constant = 0
        chiefViewHeight.constant = 0
        investigationViewHeight.constant = 0
        probableViewHeight.constant = 0
        examinationViewHeight.constant = 0
        patientView.isHidden = true
        chiefComplaint.isHidden = true
        investigationView.isHidden = true
        probableDiagnosis.isHidden = true
        examinationView.isHidden = true
        scrollViewHeight.constant = 800
    }
    @IBAction func chiefClicked(_ sender: UIButton) {
        chiefEnabled = !chiefEnabled
        if chiefEnabled {
            chiefViewHeight.constant = 60
        } else {
            chiefViewHeight.constant = 60
        }
       
        chiefComplaint.isHidden = !chiefEnabled
        updateScrollView()
        
    }
    @IBAction func historyClicked(_ sender: UIButton) {
        historyEnabled = !historyEnabled
        if historyEnabled {
            patientViewHeight.constant = 290
            historyAdd.setTitle("Hide", for: .normal)
        } else {
            patientViewHeight.constant = 290
            historyAdd.setTitle("+ Add", for: .normal)
        }
       
        patientView.isHidden = !historyEnabled
        updateScrollView()
    }
    @IBAction func examinationClicked(_ sender: UIButton) {
        examinationEnabled = !examinationEnabled
        if examinationEnabled {
            examinationViewHeight.constant = 185
            examAdd.setTitle("Hide", for: .normal)
        } else {
            examinationViewHeight.constant = 0
            examAdd.setTitle("+ Add", for: .normal)
        }
    
        examinationView.isHidden = !examinationEnabled
        updateScrollView()
    }
    @IBAction func investigationClicked(_ sender: UIButton) {
        invistigationEnabled = !invistigationEnabled
        if invistigationEnabled {
            investigationViewHeight.constant = 185
            invigstAdd.setTitle("Hide", for: .normal)
        } else {
            investigationViewHeight.constant = 0
            invigstAdd.setTitle("+ Add", for: .normal)
        }
       
        investigationView.isHidden = !invistigationEnabled
        updateScrollView()
    }
    @IBAction func diagnosticsClicked(_ sender: UIButton) {
        diagnosisEnabled = !diagnosisEnabled
        if diagnosisEnabled {
            probableViewHeight.constant = 60
        } else {
            probableViewHeight.constant = 60
        }
      
        probableDiagnosis.isHidden = !diagnosisEnabled
        updateScrollView()
    }
    func updateScrollView() {
        scrollViewHeight.constant = 800
        if chiefEnabled {
            scrollViewHeight.constant = scrollViewHeight.constant + chiefViewHeight.constant
        }
        if historyEnabled {
            scrollViewHeight.constant = scrollViewHeight.constant + patientViewHeight.constant
        }
        if examinationEnabled {
            scrollViewHeight.constant = scrollViewHeight.constant + examinationViewHeight.constant
        }
        if invistigationEnabled {
            scrollViewHeight.constant = scrollViewHeight.constant + investigationViewHeight.constant
        }
        if diagnosisEnabled {
            scrollViewHeight.constant = scrollViewHeight.constant + probableViewHeight.constant
        }
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

public struct ImageDiamenstions {
    func imageDimenssions(url: String) -> Float {
        if let imageSource = CGImageSourceCreateWithURL(URL(string: url)! as CFURL, nil) {
            if let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as Dictionary? {
                let pixelWidth = imageProperties[kCGImagePropertyPixelWidth] as! Int
                let pixelHeight = imageProperties[kCGImagePropertyPixelHeight] as! Int
                let ratio = pixelWidth / pixelHeight
                return Float(ratio)
            }
        }
        return 0
    }
}
