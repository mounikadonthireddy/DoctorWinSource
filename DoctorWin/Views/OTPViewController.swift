//
//  OTPViewController.swift
//  DoctorWin
//
//  Created by N517325 on 04/11/21.
//

import UIKit

class OTPViewController: UIViewController {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        otpTF1.setCornerRadius(radius: 10)
        otpTF2.setCornerRadius(radius: 10)
        otpTF3.setCornerRadius(radius: 10)
        otpTF4.setCornerRadius(radius: 10)
        otpVM.delegate = self
        
        verifyBtn.setCornerRadius(radius: 10)
        self.navigationItem.title = "OTP"
        self.navigationItem.backBarButtonItem?.title = ""
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        if let number = UserDefaults.standard.value(forKey: "mobileNum") {
            mobileNum.text = "OTP sent via \(number)"
        }
        //updateOTPCount()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateOTPCount), userInfo: nil, repeats: true)

    }
    
    @IBAction func verifyClicked(_ sender: Any) {
        guard let number = UserDefaults.standard.value(forKey: "mobileNum")  else { return }
        
        let otp = self.otpTF1.text! + self.otpTF2.text! + self.otpTF3.text! + self.otpTF4.text!
        let request = OTPRequest(phone_number: number as! String, otp: otp)
        
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
}
extension OTPViewController: OTPViewModelDelegate {
    func didReceiveLoginResponse(wilNavigateTo: Bool, error: String?) {
        if wilNavigateTo {
            let str = UIStoryboard(name: "Home", bundle: nil)
            let nextViewController = str.instantiateViewController(withIdentifier: "tabbar")
            nextViewController.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
}
