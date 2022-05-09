//
//  ExamDetailsViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 20/04/22.
//

import UIKit

class ExamDetailsViewController: UIViewController {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var option1Btn: UIButton!
    @IBOutlet weak var option2Btn: UIButton!
    @IBOutlet weak var option3Btn: UIButton!
    @IBOutlet weak var option4Btn: UIButton!
    @IBOutlet weak var answerLbl: UILabel!
    @IBOutlet weak var explanationLbl: UILabel!
    var examData: HomeDataModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        option1Btn.setCornerRadiusWithBorderColor(radius: 5, color: UIColor.lightGray, borderWidth: 1)
        option2Btn.setCornerRadiusWithBorderColor(radius: 5, color: UIColor.lightGray, borderWidth: 1)
        
        option3Btn.setCornerRadiusWithBorderColor(radius: 5, color: UIColor.lightGray, borderWidth: 1)
        
        option4Btn.setCornerRadiusWithBorderColor(radius: 5, color: UIColor.lightGray, borderWidth: 1)
        explanationLbl.setCornerRadiusWithBorderColor(radius: 5, color: UIColor.lightGray, borderWidth: 1)

        if let data = examData  {
            self.titleLbl.text = data.question
            
            self.option1Btn.setTitle("   A. \(data.option1 ?? "")", for: .normal)
            self.option2Btn.setTitle("   B. \(data.option2 ?? "")", for: .normal)
            self.option3Btn.setTitle("   C. \(data.option3 ?? "")", for: .normal)
            self.option4Btn.setTitle("   D. \(data.option4 ?? "")", for: .normal)
            self.answerLbl.text = "Correct Answer is: \(data.correctAnswer ?? "")"
            self.explanationLbl.text = data.detail
            
            switch data.correctAnswer  {
            case "A":
                self.option1Btn.backgroundColor = UIColor(rgb: 0x008000)
            case "B":
                self.option2Btn.backgroundColor = UIColor(rgb: 0x008000)
            case "C":
                self.option3Btn.backgroundColor = UIColor(rgb: 0x008000)
            case "D":
                self.option4Btn.backgroundColor = UIColor(rgb: 0x008000)
            case .none:
                break
            
            case .some(_):
                break
            }
        }

        // Do any additional setup after loading the view.
    }
    @IBAction func backClikced(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
