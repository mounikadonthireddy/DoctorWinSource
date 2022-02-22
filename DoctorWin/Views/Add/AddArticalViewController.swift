//
//  AddArticalViewController.swift
//  DoctorWin
//
//  Created by N517325 on 01/11/21.
//

import UIKit

class AddArticalViewController: ViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var newTitleTF: UITextField!
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var postBtn: UIButton!
    var imageFileName: String = ""
    var fileType: String = ""
    var imagePicker: ImagePicker!
    var path: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.setCornerRadiusWithBorderColor(radius: 0, color: UIColor.lightGray, borderWidth: 1)
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        descriptionTV.textColor = UIColor.lightGray 
    }
    
    
    @IBAction func addImageClicked(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
        
    }
    @IBAction func postClicked(_ sender: Any) {
        if imageFileName == "" {
            showAlertView(message: "Please select image")
            
        } else if newTitleTF.text == "" {
            showAlertView(message: "Please Enter News title")
        } else if descriptionTV.text == "" {
            showAlertView(message: "Please Enter News Description")

        } else {
            let param = ["artical_title": newTitleTF.text!, "artical_discription": descriptionTV.text!, "user": User.shared.userID] as [String : Any]
            self.showLoader()
            let url = "http://3.132.212.116:8000/api/ios/artical?user_id=\(User.shared.userID)"
            HttpUtility().profileUpload(img: self.imageView.image!, url: url, imageName: self.imageFileName, imageUploadName: "mediafile", param: param) { res in
                DispatchQueue.main.async {
                    self.dismiss()
                    print(res)
                    self.showAlertView(message: "News Posted Successfully")
                }
                
            }
        }
    }
    func showAlertView(message: String) {
        
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.OkAlertTitle, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    
}

extension AddArticalViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?, fileName: String?, fileType: String?) {
        self.imageView.image = image
        self.imageFileName = fileName ?? ""
        self.fileType = fileType ?? ""
    }
    
}
extension AddArticalViewController: UITextFieldDelegate, UITextViewDelegate {
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
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Add Article Description"
            textView.textColor = UIColor.lightGray
        }
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
}
