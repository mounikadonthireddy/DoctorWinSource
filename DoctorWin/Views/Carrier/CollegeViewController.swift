//
//  CollegeViewController.swift
//  DoctorWin
//
//  Created by N517325 on 28/10/21.
//

import UIKit

class CollegeViewController: UIViewController {
    var collegeDataArray: [CollegeDataModel] = []
    @IBOutlet weak var collegeTableView: UITableView!
    weak var jobScreenSelectionDelegate: JobScreenSelectionDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        collegeTableView.register(UINib(nibName: "CarrierCell", bundle: nil), forCellReuseIdentifier: "CarrierCell")

        self.collegeTableView.delegate = self
        self.collegeTableView.dataSource = self
        self.navigationItem.title = "News & Stories"
        
        collegeTableView.contentInsetAdjustmentBehavior = .never

        // Do any additional setup after loading the view.
        self.parse()
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    func parse() {
        if let path = Bundle.main.path(forResource: "CollegeData", ofType: "json") {
            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let decoder = JSONDecoder()
                
                if let jsonPetitions = try? decoder.decode([CollegeDataModel].self, from: data) {
                    collegeDataArray = jsonPetitions
                    collegeTableView.reloadData()
                }
            } catch let error {
                print(error)
            }
        }
        
    }


}

extension CollegeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collegeDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CarrierCell
            = tableView.dequeueReusableCell(withIdentifier: "CarrierCell", for: indexPath) as! CarrierCell
        cell.configureCell(with: collegeDataArray[indexPath.row])
        cell.courseCollectionView.reloadData()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        jobScreenSelectionDelegate?.didSelectScreen(selectedType: JobScreenSelection.college(withModel: collegeDataArray[indexPath.row]))

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    
}
