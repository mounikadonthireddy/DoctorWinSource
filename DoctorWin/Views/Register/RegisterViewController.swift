//
//  RegisterViewController.swift
//  Doctor Win
//
//  Created by N517325 on 22/10/21.
//

import UIKit
import iOSDropDown

class RegisterViewController: ViewController {
    
    @IBOutlet weak var MobileTFView: UIView!
    @IBOutlet weak var nameTFView: UIView!
    @IBOutlet weak var emailTFView: UIView!
    @IBOutlet weak var specialityTFView: UIView!
    @IBOutlet weak var qualificationTFView: UIView!
    @IBOutlet weak var locationTFView: UIView!
    @IBOutlet weak var nextButton: UIButton!

    @IBOutlet weak  var mobileNumTF: UITextField!
    @IBOutlet weak  var emailTF: UITextField!
    @IBOutlet weak  var specialityTF: DropDown!
    @IBOutlet weak  var locationTF: UITextField!
    @IBOutlet weak  var qualificationTF: DropDown!
    @IBOutlet weak var userNameTF: UITextField!
    private var registerViewModel = RegisterViewModel()
    var mobileNum: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.downloadQualificationResource()
        self.downloadSpeacilityResource()
    }
    func setupUI() {
        self.MobileTFView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor(rgb: 0x062D88), borderWidth: 1)
        self.nameTFView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor(rgb: 0x062D88), borderWidth: 1)
        self.emailTFView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor(rgb: 0x062D88), borderWidth: 1)
        self.specialityTFView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor(rgb: 0x062D88), borderWidth: 1)
        self.qualificationTFView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor(rgb: 0x062D88), borderWidth: 1)
        self.locationTFView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor(rgb: 0x062D88), borderWidth: 1)
        self.specialityTF.placeholder  = "Select Speciality"
        self.qualificationTF.placeholder  = "Select Highest Qualification"

        registerViewModel.delegate = self
        if mobileNum != "" {
            mobileNumTF.text = mobileNum
        }
        
        self.nextButton.btn_setCornerRadius(radius: self.nextButton.frame.height/2)
     
    }
    func downloadQualificationResource() {
        self.showLoader()
        let resouce = DropDownResource()
        resouce.getQualificationData { result in
            DispatchQueue.main.async {
                self.dismiss()
            }
            switch result {
                
            case .success(let data ):
                self.qualificationTF.optionArray = data.map { data in
                    return data.qualification
                }
            case .failure(_):
                print("")
            }
        }
    }
    func downloadSpeacilityResource() {
        self.showLoader()
        let resouce = DropDownResource()
        resouce.getSpecilityData { result in
            DispatchQueue.main.async {
                self.dismiss()
            }
            switch result {
                
            case .success(let data ):
                self.specialityTF.optionArray = data.map { data in
                    return data.department
                }
            case .failure(_):
                print("")
            }
        }
    }
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextClicked(_ sender: Any) {
      //  self.showLoader()
        let request = RegisterRequest(phoneNumber: self.mobileNumTF.text ?? "", name: self.userNameTF.text ?? "", email: emailTF.text ?? "", qualification: qualificationTF.text ?? "", currentLocation: locationTF.text ?? "", speciality: specialityTF.text ?? "")
        registerViewModel.registerUser(registerRequest: request)
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == mobileNumTF {
            let maxLength = 10
                let currentString: NSString = textField.text! as NSString
                let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
                return newString.length <= maxLength
        }
        return true  
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
extension RegisterViewController: RegisterViewModelDelegate {
    func didValidated(status: Bool, error: String?) {
        if status {
            self.showLoader()
        } else {
           
            DispatchQueue.main.async {
                let alert = UIAlertController(title: Constants.ErrorAlertTitle, message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: Constants.OkAlertTitle, style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    func didReceiveRegsiterResponse(wilNavigateTo: Bool, error: String?) {
        self.dismiss()
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
        nextVC.mobileNumber = self.mobileNumTF.text ?? ""
        self.navigationController?.pushViewController(nextVC, animated: true)
    } 
}
extension NSLayoutConstraint {
    /**
     Change multiplier constraint
     
     - parameter multiplier: CGFloat
     - returns: NSLayoutConstraint
     */
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {
        
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
