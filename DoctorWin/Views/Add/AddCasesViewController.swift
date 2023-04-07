//
//  AddCasesViewController.swift
//  DoctorWin
//
//  Created by N517325 on 01/11/21.
//

import UIKit

class AddCasesViewController: ViewController {
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
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    var chiefEnabled = false
    var historyEnabled = false
    var examinationEnabled = false
    var invistigationEnabled = false
    var diagnosisEnabled = false
    var imageFileName: String = ""
    var imagePicker: ImagePicker!
    var imageUpload1 : [AGImageStructInfo] = []
    
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
        collectionView.register(UINib.init(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
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
        
        if caseTitle.text == "" || chiefComplaint.text == "" {
            showAlertView(message: "Enter Mention title of the case and Description")
            
        } else {
                    
        let parm = ["title": caseTitle.text!  , "chief_complaint": chiefComplaint.text!, "present_illness": presentIllness.text! , "past_illness": pastIllness.text! , "drugs": drugs.text!  , "personal": personal.text! , "family": family.text!  , "physical_exam": physicalExamination.text! , "system_exam": systemExamination.text!  , "local_exam": localExamination.text!  , "vitus": vitus.text!  , "lab_finding": labFinding.text!  , "imaging": imaging.text! , "diagnosis": probableDiagnosis.text!]
            
            let url = ApiEndpoints.baseUrl + ApiEndpoints.addCase
            self.showLoader()
            
            
            let parameters: [String: Any] = [
                "image": imageUpload1
            ]

            AGUploadImageWebServices(url: url, parameter: parameters, inputData: parm, method: .post)
                .responseJSON { (json, eror) in
    
                    self.dismiss()
                debugPrint(json)
            }
 }
    }
    func showAlertView(message: String) {
        
    }
    @IBAction func addImageClicked(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
        
    }
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension AddCasesViewController: UITextFieldDelegate, UITextViewDelegate {
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
}
extension AddCasesViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?, fileName: String?, fileType: String?) {
        self.imageView.image = image
        self.imageFileName = fileName ?? ""
//        self.fileType = fileType ?? ""
        imageUpload1.append(AGImageStructInfo(fileName: fileName!, type: "image/jpeg", data: image!.toData()))
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
extension AddCasesViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return 5
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: ImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        if imageUpload1.count > indexPath.row {
            cell.profileImage.image = UIImage(data: imageUpload1[indexPath.row].data)
            cell.imageBtn.isHidden = true
        } else {
            cell.imageBtn.isHidden = false
        }
           
        cell.imageBtn.addTarget(self, action: #selector(selectImage(button:)), for: .touchUpInside)
//        if self.imageView.image != nil {
//            cell.profileImage.image =  self.imageView.image
//        }
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        let yourWidth = CGFloat(100)
        return CGSize(width: yourWidth, height: collectionView.bounds.height)
       
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //self.imagePicker.present(from: collectionView)
    }
    @objc func selectImage(button: UIButton) {
        self.imagePicker.present(from: button)
    }
}

