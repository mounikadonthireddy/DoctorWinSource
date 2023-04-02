//
//  ViewController.swift
//  DoctorWin
//
//  Created by N517325 on 22/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func showLoader() {
        //        DispatchQueue.main.async {
        let alert = UIAlertController(title: nil, message: "Loading...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()
        
        alert.view.addSubview(loadingIndicator)
        
        self.present(alert, animated: true, completion: nil)
        //
        //        }
    }
    func dismiss() {
        //DispatchQueue.main.async {
        self.dismiss(animated: false, completion: nil)
        //}
    }
    @IBAction func navigateToSearch(_ sender: UIButton) {
        let str = UIStoryboard(name: "Me", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    func navigateToProfile() {
     
    }
    @IBAction func navigateToRequest(_ sender: UIButton) {
        let str = UIStoryboard(name: "Network", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "RequestViewController") as! RequestViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @IBAction func navigateToProfile(_ sender: UIButton) {
        let str = UIStoryboard(name: "Me", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

}

