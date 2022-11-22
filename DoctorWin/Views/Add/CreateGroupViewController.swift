//
//  CreateGroupViewController.swift
//  DoctorWin
//
//  Created by AHP on 19/09/2565 BE.
//

import UIKit

class CreateGroupViewController: ViewController {
    @IBOutlet weak var groupNameTF: UITextField!
    @IBOutlet weak var groupDescriptionTV: UITextView!
    @IBOutlet weak var groupImage: UIButton!
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var coverImage: UIButton!
    @IBOutlet weak var coverImageView: UIImageView!
    var imageFileName: String = ""
    var imagePicker: ImagePicker!
    var imageUpload : [ImageUploadModel] = []
    var imageUpload1 : AGImageStructInfo?
    var imageUpload2 : AGImageStructInfo?
    var groupModel : GroupProfileModel?
    var tag = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        if let data = groupModel {
            groupNameTF.text = data.name_of_group ?? ""
            groupDescriptionTV.text = data.description ?? ""
            groupImage.sd_setImage(with:URL(string: ApiEndpoints.baseImageURL + (data.image ?? "")), for: .normal)
            coverImage.sd_setImage(with:URL(string: ApiEndpoints.baseImageURL + (data.cover_image ?? "")), for: .normal)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func createClicked(_ sender: UIButton) {
        let param = ["name_of_group": groupNameTF.text ?? "",
                     "description": groupDescriptionTV.text ?? ""] as [String : Any]
       self.showLoader()
        let url = ApiEndpoints.baseUrl + ApiEndpoints.createGroup

        
        let parameters: [String: Any] = [
            "image": imageUpload1,
            "cover_image": imageUpload2
        ]

        AGUploadImageWebServices(url: url, parameter: parameters, inputData: param)
            .responseJSON { (json, eror) in
                self.dismiss()
            debugPrint(json)
        }
            
      
    }
    @IBAction func groupImageClicked(_ sender: UIButton) {
        tag = 1
        self.imagePicker.present(from: sender)
    }
    @IBAction func coverImageClicked(_ sender: UIButton) {
        tag = 2
        self.imagePicker.present(from: sender)
    }

}
extension CreateGroupViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?, fileName: String?, fileType: String?) {
        if tag == 1 {
            self.groupImage.setImage(image, for: .normal)
          //  groupImageView.image = image
            imageUpload.append(ImageUploadModel(fileName: fileName!, imageName: "image", image: image!))
            
            imageUpload1 = AGImageStructInfo(fileName: fileName!, type: "image/jpeg", data: image!.toData())
           
        } else if tag == 2 {
            self.coverImage.setImage(image, for: .normal)
          //  coverImageView.image = image
            imageUpload.append(ImageUploadModel(fileName: fileName!, imageName: "cover_image", image: image!))
            imageUpload2 = AGImageStructInfo(fileName: fileName!, type: "image/jpeg", data: image!.toData())
           
        }
       
        self.imageFileName = fileName ?? ""
//        self.fileType = fileType ?? ""
    }
    
}

struct CreateGroupModel {
    let dworks_id: String
    let name_of_group: String
    let description: String
}
