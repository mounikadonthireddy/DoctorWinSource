//
//  AddStoryViewController.swift
//  DoctorWin
//
//  Created by N517325 on 01/11/21.
//

import UIKit

class AddStoryViewController: UIViewController {
    @IBOutlet weak var imageBg: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageBg.layer.borderWidth = 1
        self.imageBg.layer.borderColor = UIColor.lightGray.cgColor

        // Do any additional setup after loading the view.
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
