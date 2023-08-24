//
//  CreateAccountVC.swift
//  HWKurylenka_15_RegistrationApp
//
//

import UIKit

class CreateAccountVC: UIViewController {
    
    ///email
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var incorrectEmailLbl: UILabel!
    ///name
    @IBOutlet weak var nameTF: UITextField!
    ///password
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var weakPasswordLbl: UILabel!
    ///strongPassIndicatorsViews
    @IBOutlet var strongPassIndicatorsViews: [UIView]!
    ///confirmPassTF
    @IBOutlet weak var confirmPassTF: UITextField!
    @IBOutlet weak var errorConfirmPassLbl: UILabel!
    ///continueBtn
    @IBOutlet weak var continueBtn: UIButton!
    ///scrollView
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///Прозрачные strongPassIndicatorsViews
        strongPassIndicatorsViews.forEach { view in
            view.alpha = 0.2
        }
        ///Уменьшить скрол на высоту клавиатуры
        startKeyboardObserver()
        
        
    }
    
    
    
    private.startKeyboardObserver() {
        
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
