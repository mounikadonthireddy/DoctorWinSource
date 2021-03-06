//
//  LoginViewController.swift
//  Doctor Win
//
//  Created by N517325 on 22/10/21.
//

import UIKit

class LoginViewController: ViewController {
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var textFeildView: UIView!
    @IBOutlet weak var mobileNumTF: UITextField!
    private var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel.delegate = self
        tabBarController?.tabBar.isHidden = false
        // Do any additional setup after loading the view.
        self.loginView.setCornerRadius(radius: 15)
        self.loginButton.btn_setCornerRadius(radius: self.loginButton.frame.height/2)
        
        self.textFeildView.setCornerRadiusWithBorderColor(radius: 10, color:  UIColor.blue, borderWidth: 1)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        
    }
    @IBAction func loginClicked(_ sender: Any) {
//        self.showLoader()
        let request = LoginRequest(phoneNumber: self.mobileNumTF.text ?? "")
        loginViewModel.loginUser(loginRequest: request)
        
    }
    @IBAction func signInClicked(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

extension UITextField {
    func tf_setCornerRadius(radius: Float) {
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(radius)
    }
    func tf_setCornerRadiusWithBorderColor(radius: Float, color: UIColor, borderWidth: Float ) {
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(radius)
        self.layer.borderWidth = CGFloat(borderWidth)
        self.layer.borderColor = color.cgColor
    }
    func setUnderLine() {
            let border = CALayer()
            let width = CGFloat(0.5)
            border.borderColor = UIColor.darkGray.cgColor
            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.bounds.width + 50 , height: self.frame.size.height)
            border.borderWidth = width
            self.layer.addSublayer(border)
            self.layer.masksToBounds = true
        }
    func addInputViewDatePicker(target: Any, selector: Selector) {

        let screenWidth = UIScreen.main.bounds.width

        //Add DatePicker as inputView
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = UIColor.white
        self.inputView = datePicker

        //Add Tool Bar as input AccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)

        self.inputAccessoryView = toolBar
     }

       @objc func cancelPressed() {
         self.resignFirstResponder()
       }
    
}

extension UIButton {
    func btn_setCornerRadius(radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(radius)
    }
}
extension UIView {
    func setCornerRadius(radius: Float) {
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(radius)
    }
    func setCornerRadiusWithBorderColor(radius: Float, color: UIColor, borderWidth: Float ) {
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(radius)
        self.layer.borderWidth = CGFloat(borderWidth)
        self.layer.borderColor = color.cgColor
    }
}
