//
//  AddQuestionViewController.swift
//  DoctorWin
//
//  Created by AHP on 07/09/2565 BE.
//

import UIKit

class AddQuestionViewController: ViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var questionTV: UITextView!
    @IBOutlet weak var postBtn: UIButton!
    var questionVM = PostQuestionsViewModel()
    var isHeaderVisible: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.isHidden = isHeaderVisible
        if !isHeaderVisible {
            headerViewHeight.constant = 50
        }
        questionVM.delegate = self
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func postClicked(_ sender: UIButton){
        let request = QuestionRequestModel(question: questionTV.text, status: true)
        self.showLoader()
        questionVM.getQuestionResponseData(questionRequest: request, userID: User.shared.userID)
        
    }
    @IBAction func closeClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension AddQuestionViewController: PostQuestionViewModelDelegate {
    func didPostedQuestion(status: Bool, error: String?) {
        self.dismiss()
    }
    
    
}
