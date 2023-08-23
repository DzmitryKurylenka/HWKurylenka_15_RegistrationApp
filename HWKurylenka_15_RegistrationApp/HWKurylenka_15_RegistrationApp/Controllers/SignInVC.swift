//
//  SignInVC.swift
//  HWKurylenka_15_RegistrationApp
//
//  Created by MACBOOK PRO 15,4 2017 ROK on 23/08/2023.
//

import UIKit

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var incorrectLbl: UILabel! {
        ///Сделаем сообщение невидимым через вычисляемое свойство.
        ///Но можно вынести ниже в setupUI
        didSet {incorrectLbl.isHidden = true}
    }
    @IBOutlet weak var signInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    private func setupUI() {
        ///Сделать кнопку signIn неактивной
        signInBtn.isEnabled = false
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
