//
//  ProfileVC.swift
//  HWKurylenka_15_RegistrationApp
//
//

import UIKit

class ProfileVC: UIViewController {

    @IBAction func deleteAccountAction() {
        ///Удалим аккаунт
        UserDefaultsService.cleanUserDefaults()
        /// И переходим на экран SignIn
        navigationController?.popToRootViewController(animated: true)
        
    }
    /// При выходе переходим на экран SignIn
    @IBAction func logOutAction() {
        navigationController?.popToRootViewController(animated: true)
    }

}
