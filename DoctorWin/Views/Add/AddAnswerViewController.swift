//
//  AddAnswerViewController.swift
//  DoctorWin
//
//  Created by AHP on 12/10/2565 BE.
//

import UIKit

class AddAnswerViewController: UIViewController {

    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var questionTF: UITextView!
    @IBOutlet weak var selectedImage: UIImageView!
    var askedQuestion = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if askedQuestion != "" {
            questionLbl.text = askedQuestion
        }

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
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
    @IBAction func cameraClicked(_ sender: UIButton) {
        
    }
    @IBAction func gallaryClicked(_ sender: UIButton) {
        
    }
    @IBAction func postClicked(_ sender: UIButton) {
        
    }
}
