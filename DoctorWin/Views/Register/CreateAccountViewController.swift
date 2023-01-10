//
//  CreateAccountViewController.swift
//  DoctorWin
//
//  Created by AHP on 29/12/2565 BE.
//

import UIKit
import SkyFloatingLabelTextField


class CreateAccountViewController: ViewController {
    @IBOutlet weak  var emailTF: SkyFloatingLabelTextField!
    @IBOutlet weak  var passwordTF: SkyFloatingLabelTextField!
    @IBOutlet weak var nextButton: UIButton!
    var mobileNum = ""
    var userName = ""
    var speciality = ""
    private var registerViewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerViewModel.delegate = self
       setupUI()
    }
    func setupUI() {
        emailTF.title = "Email Address*"
        passwordTF.title = "Password*"
        self.nextButton.btn_setCornerRadius(radius: self.nextButton.frame.height/2)
    }

    @IBAction func nextClicked(_ sender: Any) {
        self.showLoader()
        let request = RegisterRequest(phone_number: mobileNum , name: userName, email: emailTF.text ?? "", speciality: speciality, password: self.passwordTF.text ?? "")
        registerViewModel.registerUser(registerRequest: request)
    }
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
extension CreateAccountViewController: RegisterViewModelDelegate {
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
    
    func didReceiveRegsiterResponse(userData: LoginUserDetails?, error: String?) {
        self.dismiss()
        if let data = userData {
            UserDefaults.standard.setValue("\(data.name ?? "")", forKey: "username")
            UserDefaults.standard.setValue(data.phone_number ?? "", forKey: "mobileNum")
            UserDefaults.standard.set(data.dating_profile_status, forKey: "datingProfile")
            UserDefaults.standard.setValue("\(data.token ?? "")", forKey: "token")
            if data.profile_image == false {
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePicViewController") as! ProfilePicViewController
               
                self.navigationController?.pushViewController(nextVC, animated: true)
                
            } else if data.cover_image == false {
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "CoverPicViewController") as! CoverPicViewController
               
                self.navigationController?.pushViewController(nextVC, animated: true)
            } else {
                let str = UIStoryboard(name: "Tab", bundle: nil)
                let nextViewController = str.instantiateViewController(withIdentifier: "tabView")
                
                nextViewController.navigationController?.isNavigationBarHidden = true
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
        
    }
}
extension CreateAccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
