//
//  ImageDetailsViewController.swift
//  DoctorWin
//
//  Created by AHP on 05/06/2565 BE.
//

import UIKit

class ImageDetailsViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var discussionsCount: UILabel!
   var selectedImageUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if selectedImageUrl != "" {
            image.sd_setImage(with: URL(string: selectedImageUrl))
       
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
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

    @IBAction func shareClicked(_ sender: UIButton) {
        
    }
    @IBAction func messageClicked(_ sender: UIButton) {
        
    }
    @IBAction func repostClicked(_ sender: UIButton) {
        
    }
    @IBAction func likeClicked(_ sender: UIButton) {
        
    }
    @IBAction func saveClicked(_ sender: UIButton) {
        
    }
}
