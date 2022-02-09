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
    @IBOutlet weak var loginButton: UIButton!
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
    }
    func setupUI() {
        self.MobileTFView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor.blue, borderWidth: 1)
        self.nameTFView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor.blue, borderWidth: 1)
        self.emailTFView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor.blue, borderWidth: 1)
        self.specialityTFView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor.blue, borderWidth: 1)
        self.qualificationTFView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor.blue, borderWidth: 1)
        self.locationTFView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor.blue, borderWidth: 1)
        
        registerViewModel.delegate = self
        if mobileNum != "" {
            mobileNumTF.text = mobileNum
        }
        
        self.nextButton.btn_setCornerRadius(radius: self.nextButton.frame.height/2)
        self.loginButton.btn_setCornerRadius(radius: self.loginButton.frame.height/2)

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
        self.navigationController?.pushViewController(nextVC, animated: true)
    } 
}
