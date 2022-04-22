//
//  LoginVCExtension.swift
//  MvvmDemoApp
//
//  Created by CodeCat15 on 3/14/20.
//  Copyright © 2020 Codecat15. All rights reserved.
//

import Foundation
import UIKit

extension LoginViewController : LoginViewModelDelegate {
    func didValidated(status: Bool, error: String?) {
        if status == false {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: Constants.ErrorAlertTitle, message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: Constants.OkAlertTitle, style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        } else {
            self.showLoader()
        }
    }
    
    func didReceiveLoginResponse(wilNavigateTo: Bool, error: String?) {
        self.dismiss()
        
        if wilNavigateTo == true {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
            nextVC.mobileNum = self.mobileNumTF.text ?? ""
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        else if wilNavigateTo == false && error == nil {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else if wilNavigateTo == false && error != nil {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: Constants.ErrorAlertTitle, message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: Constants.OkAlertTitle, style: .default, handler: nil))
                self.present(alert, animated: true)
            }
           
        }
    }
    
    
}

extension LoginViewController: UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let maxLength = 10
//        let currentString: NSString = textField.text! as NSString
//        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
//        return newString.length <= maxLength
//        
//    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        mobileNumTF.resignFirstResponder()
    }
}
