//
//  CreateGroupViewController.swift
//  DoctorWin
//
//  Created by AHP on 19/09/2565 BE.
//

import UIKit

class CreateGroupViewController: UIViewController {
    @IBOutlet weak var groupNameTF: UITextField!
    @IBOutlet weak var groupDescriptionTV: UITextView!
    @IBOutlet weak var groupImage: UIButton!
    @IBOutlet weak var coverImage: UIButton!
    var imageFileName: String = ""
    var imagePicker: ImagePicker!
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
        
    }
    @IBAction func groupImageClicked(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    @IBAction func coverImageClicked(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }

}
extension CreateGroupViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?, fileName: String?, fileType: String?) {
        if tag == 0 {
            self.groupImage.setImage(image, for: .normal)
           
        } else if tag == 1 {
            self.coverImage.setImage(image, for: .normal)
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
