//
//  EditBioDataController.swift
//  DoctorWin
//
//  Created by AHP on 01/09/2565 BE.
//

import UIKit

class EditBioDataController: ViewController {
    @IBOutlet weak var profileTableView: UITableView!
    var profileDataModel : ProfileDataModel!
    @IBOutlet weak var imageView : UIImageView!
    var imageFileName: String = ""
    var fileType: String = ""
    var imagePicker: ImagePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)

      
        profileTableView.register(UINib(nibName: "ProfileImageCell", bundle: nil), forCellReuseIdentifier: "ProfileImageCell")
        
      
      
       
      
        
        profileTableView.register(UINib(nibName: "EditSkillCell", bundle: nil), forCellReuseIdentifier: "EditSkillCell")
        
        self.navigationController?.isNavigationBarHidden = true
        profileTableView.contentInset = UIEdgeInsets(top: -10, left: 0, bottom: 0, right: 0)
        
        
      
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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tabBarController?.tabBar.isHidden = true
        
    }
 
    @IBAction func backClikced(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension EditBioDataController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell: ProfileImageCell = tableView.dequeueReusableCell(withIdentifier: "ProfileImageCell", for: indexPath) as! ProfileImageCell
            // cell.configurePersonalEditCell(data: profileDataModel)
            cell.saveBtn.addTarget(self, action: #selector(imageUpload(button:)), for: .touchUpInside)
            cell.addImage.addTarget(self, action: #selector(selectImage(button:)), for: .touchUpInside)
            if self.imageView.image != nil {
                cell.profileImage.image =  self.imageView.image
            }
            cell.cellConfigureWith(data: profileDataModel)
            return cell
        
       
            
        case 1:
            let cell: EditSkillCell = tableView.dequeueReusableCell(withIdentifier: "EditSkillCell", for: indexPath) as! EditSkillCell
            cell.configureCellWithEdit(data: profileDataModel, section: 2)
            cell.profileDelegate = self
            cell.detailsTF.delegate = self
            return cell
            
            
        default:
            
            return UITableViewCell()
            
        }
    }
    
    @objc func selectImage(button: UIButton) {
        self.imagePicker.present(from: button)
    }
    @objc func imageUpload(button: Any) {
        let param = [:] as [String : Any]
        self.showLoader()
        let url = ApiEndpoints.baseUrl + ApiEndpoints.profileEdit + ApiEndpoints.userID + "=\(User.shared.userID)"

        HttpUtility().profileUpload(img: self.imageView.image!, url: url, imageName: self.imageFileName, imageUploadName: "profileImage", param: param) { res in
            DispatchQueue.main.async {
                self.dismiss()
                print(res)
               // self.showAlertView(message: "News Posted Successfully")
                
            }
            
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 4 {
            return 350
        } else {
            return UITableView.automaticDimension
        }
    }
}

extension EditBioDataController: ProfileUpdateDelegate {
    func didProfileUpdated(status: Bool, error: String?) {
        let alert = UIAlertController(title: nil, message: "Profile Updated Successfully", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: Constants.OkAlertTitle, style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    
}
extension EditBioDataController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

extension EditBioDataController: ImagePickerDelegate {
    func didSelect(image: UIImage?, fileName: String?, fileType: String?) {
        self.imageView.image = image
        self.imageFileName = fileName ?? ""
        self.fileType = fileType ?? ""
        self.profileTableView.reloadData()
    }
    
}
