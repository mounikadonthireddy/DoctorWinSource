//
//  OTPViewController.swift
//  DoctorWin
//
//  Created by N517325 on 04/11/21.
//

import UIKit

class OTPViewController: ViewController {
    @IBOutlet weak var otpTF1: UITextField!
    @IBOutlet weak var otpTF2: UITextField!
    @IBOutlet weak var otpTF3: UITextField!
    @IBOutlet weak var otpTF4: UITextField!
    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var resendBtn: UIButton!
    @IBOutlet weak var mobileNum: UILabel!
    var otpVM =  OTPViewModel ()
    var count = 60
    var resendTimer = Timer()
    var mobileNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        otpTF1.setCornerRadiusWithBorderColor(radius: 11, color: UIColor(rgb: 0x062D88), borderWidth: 1)
        otpTF2.setCornerRadiusWithBorderColor(radius: 11, color: UIColor(rgb: 0x062D88), borderWidth: 1)
        otpTF3.setCornerRadiusWithBorderColor(radius: 11, color: UIColor(rgb: 0x062D88), borderWidth: 1)
        otpTF4.setCornerRadiusWithBorderColor(radius: 11, color: UIColor(rgb: 0x062D88), borderWidth: 1)
        otpVM.delegate = self
        
        verifyBtn.setCornerRadius(radius: 10)
        self.navigationItem.title = "OTP"
        self.navigationItem.backBarButtonItem?.title = ""
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        mobileNum.text = "OTP sent via \(mobileNumber)"
        
        //updateOTPCount()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateOTPCount), userInfo: nil, repeats: true)
        
        //        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        //        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    @IBAction func verifyClicked(_ sender: Any) {
        
        let otp = self.otpTF1.text! + self.otpTF2.text! + self.otpTF3.text! + self.otpTF4.text!
        let request = OTPRequest(phone_number: mobileNumber , otp: otp)
        
        otpVM.validateOTP(request: request)
    }
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func resendClicked(_ sender: Any) {
        if resendBtn.titleLabel?.text  != "resend" {
            print("call resend")
            let resource = LoginResource()
            let request = LoginRequest(phoneNumber: UserDefaults.standard.value(forKey: "mobileNum") as! String)
            
            resource.resendOtp(request: request) { res in
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: nil, message: "OTP Sented Successfully", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: Constants.OkAlertTitle, style: .default, handler: nil))
                    self.present(alert, animated: true)
                    
                    self.updateOTPCount()
                    self.resendBtn.isUserInteractionEnabled = false
                }
            }
        } else {
            updateOTPCount()
            resendBtn.isUserInteractionEnabled = false
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    @objc func updateOTPCount() {
        if(count > 0) {
            count = count - 1
            let str = self.timeFormatted(count)
            resendBtn.setTitle(str, for: .normal)
        }
        else {
            resendTimer.invalidate()
            resendBtn.setTitle("Resend", for: .normal)
            resendBtn.isUserInteractionEnabled = true
        }
    }
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
extension OTPViewController: UITextFieldDelegate {
    func textFieldShouldReturnSingle(_ textField: UITextField , newString : String) {
        let nextTag: Int = textField.tag + 1
        
        let nextResponder: UIResponder? = textField.superview?.superview?.viewWithTag(nextTag)
        textField.text = newString
        if let nextR = nextResponder {
            nextR.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newString = ((textField.text)! as NSString).replacingCharacters(in: range, with: string)
        
        let newLength = newString.count
        
        if newLength == 1 {
            textFieldShouldReturnSingle(textField , newString : newString)
            return false
        }
        
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        otpTF1.resignFirstResponder()
        otpTF2.resignFirstResponder()
        otpTF3.resignFirstResponder()
        otpTF4.resignFirstResponder()
    }
}
extension OTPViewController: RegisterViewModelDelegate {
    
    func didReceiveRegsiterResponse(userData: LoginUserDetails?, error: String?) {
        
        self.dismiss()
        if let data = userData {
         UserDefaults.standard.setValue("\(data.name ?? "")", forKey: "username")
            UserDefaults.standard.setValue(data.phone_number ?? "", forKey: "mobileNum")
            UserDefaults.standard.set(data.dating_profile_status, forKey: "datingProfile")
            UserDefaults.standard.setValue("\(data.token ?? "")", forKey: "token")
            User.shared.token = data.token ?? ""
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
        } else {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
            nextVC.mobileNum = mobileNumber
            
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
    }
}
