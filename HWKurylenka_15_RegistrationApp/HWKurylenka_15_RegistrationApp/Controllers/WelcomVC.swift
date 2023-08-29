//
//  WelcomVC.swift
//  HWKurylenka_15_RegistrationApp
//
//

import UIKit

class WelcomVC: UIViewController {
    
    @IBOutlet weak var infoLbl: UILabel!
    
    var userModel: UserModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func continueAction() {
        // TODO: save data
        /// Возвращение на самый первый экран
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func setupUI() {
        infoLbl.text = "\(userModel?.name ?? "") to our Cool App"
    }
    
}
