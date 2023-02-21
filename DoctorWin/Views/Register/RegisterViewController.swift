//
//  RegisterViewController.swift
//  Doctor Win
//
//  Created by N517325 on 22/10/21.
//

import UIKit
import iOSDropDown
import SkyFloatingLabelTextField

class RegisterViewController: ViewController {
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak  var specialityTF: DropDown!
    @IBOutlet weak var userNameTF: SkyFloatingLabelTextField!
    var mobileNum: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
       
        self.downloadSpeacilityResource()
    }
    func setupUI() {
        userNameTF.title = "Full Name*"
        self.specialityTF.placeholder  = "Select Speciality"
        self.nextButton.btn_setCornerRadius(radius: self.nextButton.frame.height/2)
     
    }
   
    func downloadSpeacilityResource() {
        //self.showLoader()
        let resouce = DropDownResource()
        resouce.getSpecilityData { result in
            DispatchQueue.main.async {
                self.dismiss()
            }
            switch result {
                
            case .success(let data ):
                self.specialityTF.optionArray = data.map { data in
                    return data.Speciality ?? ""
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
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateAccountViewController") as! CreateAccountViewController
        nextVC.mobileNum = mobileNum
        nextVC.userName = userNameTF.text ?? ""
        nextVC.speciality = specialityTF.text ?? ""
        self.navigationController?.pushViewController(nextVC, animated: true)
      
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
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
