//
//  AddNewsViewController.swift
//  DoctorWin
//
//  Created by N517325 on 01/11/21.
//

import UIKit
import Alamofire
import Photos

public protocol ImagePickerDelegate: class {
    func didSelect(image: UIImage?, fileName: String?, fileType: String?)
}
open class ImagePicker: NSObject {
    
    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    
    private  var fileName: String?
    private  var fileType: String?
    
    public init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
        self.pickerController = UIImagePickerController()
        
        super.init()
        
        self.presentationController = presentationController
        self.delegate = delegate
        
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image"]
        
        
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }
    
    public func present(from sourceView: UIView) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if let action = self.action(for: .camera, title: "Take photo") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .savedPhotosAlbum, title: "Camera roll") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .photoLibrary, title: "Photo library") {
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        
        self.presentationController?.present(alertController, animated: true)
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        
        self.delegate?.didSelect(image: image, fileName: fileName, fileType: fileType)
    }
}

extension ImagePicker: UIImagePickerControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            fileName = url.lastPathComponent
            fileType = url.pathExtension
            
        }
        
        self.pickerController(picker, didSelect: image)
    }
}

extension ImagePicker: UINavigationControllerDelegate {
    
}

class AddNewsViewController: ViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var newTitleTF: UITextField!
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backViewHeight: NSLayoutConstraint!
    var showBack:Bool = false

    var imageFileName: String = ""
    var fileType: String = ""
    var imagePicker: ImagePicker!
    var path: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.setCornerRadiusWithBorderColor(radius: 0, color: UIColor.lightGray, borderWidth: 1)
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddNewsViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddNewsViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
        descriptionTV.textColor = UIColor.lightGray
        if !showBack {
                   backView.isHidden = true
                   backViewHeight.constant = 0
               }
    }
    
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
            
            
            let param = ["artical_title": newTitleTF.text!, "artical_discription": descriptionTV.text!] as [String : Any]
            self.showLoader()
            let url = "http://3.132.212.116:8000/api/news/artical/post?user_id=\(User.shared.userID)"
            HttpUtility().profileUpload(img: self.imageView.image!, url: url, imageName: self.imageFileName, imageUploadName: "artical_image", param: param) { res in
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
        
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                    
                    
                }
                
                alertController.addAction(OKAction)
                
                self.present(alertController, animated: true, completion:nil)
    }
    
    
}

extension AddNewsViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?, fileName: String?, fileType: String?) {
        self.imageView.image = image
        self.imageFileName = fileName ?? ""
        self.fileType = fileType ?? ""
    }
    
}
extension AddNewsViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Add News Description"
            textView.textColor = UIColor.lightGray
        }
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
