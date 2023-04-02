//
//  ProfilePicViewController.swift
//  DoctorWin
//
//  Created by AHP on 29/12/2565 BE.
//

import UIKit

class ProfilePicViewController: ViewController {
    var imagePicker: ImagePicker!
    var imageUpload1 : [AGImageStructInfo] = []
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var imageBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        self.nextButton.btn_setCornerRadius(radius: self.nextButton.frame.height/2)
        imageBtn.setCornerRadiusWithBorderColor(radius: 10, color: UIColor.blue, borderWidth: 0.3)
        // Do any additional setup after loading the view.
    }
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func skipClicked(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "CoverPicViewController") as! CoverPicViewController
       
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @IBAction func submitClicked(_ sender: Any) {
        self.showLoader()
        let parm = [String: Any]()
            
            let url = ApiEndpoints.baseUrl + ApiEndpoints.getDatingImages
            self.showLoader()
            
            
            let parameters: [String: Any] = [
                "image": imageUpload1
            ]

        AGUploadImageWebServices(url: url, parameter: parameters, inputData: parm, method: .put)
                .responseJSON { (json, eror) in
    
                    self.dismiss()
                    let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "CoverPicViewController") as! CoverPicViewController
                   
                    self.navigationController?.pushViewController(nextVC, animated: true)
                debugPrint(json)
            }
    }
    @IBAction func ImageClicked(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
}
extension ProfilePicViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?, fileName: String?, fileType: String?) {
        imageBtn.setBackgroundImage(image, for: .normal)
        imageUpload1.append(AGImageStructInfo(fileName: fileName ?? "jpg", type: "image/jpeg", data: image!.toData()))
    }
    
}
struct ImageUploadResponse: Codable {
    let is_active: Bool?
}
