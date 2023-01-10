//
//  CoverPicViewController.swift
//  DoctorWin
//
//  Created by AHP on 29/12/2565 BE.
//

import UIKit

class CoverPicViewController: ViewController {
    var imagePicker: ImagePicker!
    var imageUpload1 : [AGImageStructInfo] = []
    @IBOutlet weak var imageBtn: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextButton.btn_setCornerRadius(radius: self.nextButton.frame.height/2)
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        imageBtn.setCornerRadiusWithBorderColor(radius: 10, color: UIColor.blue, borderWidth: 0.3)
        // Do any additional setup after loading the view.
    }
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func submitClicked(_ sender: Any) {
        self.showLoader()
        let parm = [String: Any]()
            
            let url = ApiEndpoints.baseUrl + ApiEndpoints.register
            self.showLoader()
            
            
            let parameters: [String: Any] = [
                "cover_image": imageUpload1
            ]

        AGUploadImageWebServices(url: url, parameter: parameters, inputData: parm, method: .put)
                .responseJSON { (json, eror) in
    
                    self.dismiss()
                debugPrint(json)
            }
    }
    @IBAction func ImageClicked(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    @IBAction func skipClicked(_ sender: Any) {
        let str = UIStoryboard(name: "Tab", bundle: nil)
        let nextViewController = str.instantiateViewController(withIdentifier: "tabView")
        
        nextViewController.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }

}
extension CoverPicViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?, fileName: String?, fileType: String?) {
        imageBtn.setBackgroundImage(image, for: .normal)
        imageUpload1.append(AGImageStructInfo(fileName: fileName!, type: "image/jpeg", data: image!.toData()))
    }
    
}
