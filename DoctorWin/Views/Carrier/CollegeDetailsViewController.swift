//
//  CollegeDetailsViewController.swift
//  DoctorWin
//
//  Created by N517325 on 28/10/21.
//

import UIKit
import SDWebImage

class CollegeDetailsViewController: UIViewController {
    @IBOutlet weak var collegeTableView: UITableView!
    var collegeDataModel : CollegeDataModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        collegeTableView.register(UINib(nibName: "CollegeDetailsCell", bundle: nil), forCellReuseIdentifier: "CollegeDetailsCell")

        self.collegeTableView.delegate = self
        self.collegeTableView.dataSource = self
        self.navigationItem.title = "News & Stories"
        
        
       
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
    }

   
}
extension CollegeDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CollegeDetailsCell
            = tableView.dequeueReusableCell(withIdentifier: "CollegeDetailsCell", for: indexPath) as! CollegeDetailsCell
    
        cell.configureCollegeCell(With: collegeDataModel)

        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        300
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame : CGRect(x : 0,y:0, width : tableView.frame.width , height : 300))
        
                
        
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 300)
        let headerImageView = UIImageView(frame: frame)
        headerImageView.sd_setImage(with: URL(string: "http://3.132.212.116:8000/media/com/image_0jJqUjr.jpg"), placeholderImage: UIImage(named: "loginBg"))
        headerImageView.backgroundColor = UIColor.red
        header.addSubview(headerImageView)
        let button = UIButton(frame: CGRect(x: 5, y: 10, width: 60, height: 60))
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(pressButton(button:)), for: .touchUpInside)
        header.addSubview(button)
        
        return header
    }
    @objc func pressButton(button: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

struct collegeDiscussion {
    let name: String
    let key: String
}






