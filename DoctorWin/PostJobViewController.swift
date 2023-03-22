//
//  PostJobViewController.swift
//  DoctorWin
//
//  Created by AHP on 22/03/2566 BE.
//

import UIKit

class PostJobViewController: UIViewController {
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["Jobs","Cases",  "News", "Social","Answers"])
            interfaceSegmented.selectorViewColor = .black
            interfaceSegmented.selectorTextColor = .black
            interfaceSegmented.clipsToBounds = true
            interfaceSegmented.setCornerRadius(radius: 10)
        }
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHieght: NSLayoutConstraint!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "FAQCell", bundle: nil), forCellReuseIdentifier: "FAQCell")

        // Do any additional setup after loading the view.
    }
    func configureData() {
        tableViewHieght.constant = 150 + (44 * 4)
    }
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
extension PostJobViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FAQCell
        = tableView.dequeueReusableCell(withIdentifier: "FAQCell") as! FAQCell
        return cell
    }
    
    
}

