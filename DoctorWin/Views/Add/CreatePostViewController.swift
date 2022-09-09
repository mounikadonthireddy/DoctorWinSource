//
//  CreatePostViewController.swift
//  DoctorWin
//
//  Created by AHP on 07/09/2565 BE.
//

import UIKit

class CreatePostViewController: UIViewController {
    var delegate: AddScreenSelectionDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

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
    @IBAction func caseClicked(_ sender: UIButton) {
        delegate?.didSelectScreen(selectedType: .caseDiscussion)
    }
    @IBAction func cameraClicked(_ sender: UIButton) {
        delegate?.didSelectScreen(selectedType: .camera)
    }
    @IBAction func photoClicked(_ sender: UIButton) {
        delegate?.didSelectScreen(selectedType: .gallary)
    }
    @IBAction func saleClicked(_ sender: UIButton) {
        delegate?.didSelectScreen(selectedType: .sale)
    }
}
