//
//  AddPollViewController.swift
//  DoctorWin
//
//  Created by N517325 on 01/11/21.
//

import UIKit

class AddPollViewController: ViewController {
    
    @IBOutlet weak var questionTF: UITextField!
    @IBOutlet weak var option1TF: UITextField!
    @IBOutlet weak var option2TF: UITextField!
    @IBOutlet weak var option3TF: UITextField!
    @IBOutlet weak var option4TF: UITextField!
    var pollVM: PollViewModel = PollViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        pollVM.delegate = self
        
    }
    
    
    @IBAction func postClicked(_ sender: UIButton) {
        let pollModel = AddPollRequestModel(poll_title: questionTF.text ?? "", option1: option1TF.text ?? "", option2: option2TF.text ?? "", option3: option3TF.text ?? "", option4: option4TF.text ?? "", poll_user: User.shared.userID)
        self.showLoader()
        pollVM.addPollData(pollModel: pollModel)
    }
}
extension AddPollViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
extension AddPollViewController: PollViewModelDelegate {
    func didRecivePollAddStatus(response: BoolResponseModel?, error: String?) {
        DispatchQueue.main.async {
            self.dismiss()
        if error == nil {
            let alert = UIAlertController(title: nil, message: "Poll Posted Successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Constants.OkAlertTitle, style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    }
    
    
}
struct AddPollRequestModel: Codable {
    
    let poll_title: String
    let option1: String
    let option2: String
    let option3: String
    let option4: String
    let poll_user: String
}
