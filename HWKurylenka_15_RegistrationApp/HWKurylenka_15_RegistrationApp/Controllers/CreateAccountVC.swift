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
    
    private var isValidEmail = false
    private var isConfPass = false
//    private var passwordStreigth = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///Прозрачные strongPassIndicatorsViews
        strongPassIndicatorsViews.forEach { view in view.alpha = 0.2}
        ///Уменьшить скрол на высоту клавиатуры
        startKeyboardObserver()
        ///Скрытие клавиатуры при нажатии на любом месте на экране
        hideKeyboardWhenTappedAround()
        
    }
    
    @IBAction func emailTFAction(_ sender: UITextField) {
        if let email = sender.text,
        /// Проверка что поле не пустое
           !email.isEmpty,
        /// Верифицируем наш email
           VerificationCervice.isValidEmail(email: email){
            isValidEmail = true
        } else {
            isValidEmail = false
        }
        /// Скроем валидац сообщение если введен корректный email
        incorrectEmailLbl.isHidden = isValidEmail
    }
    
    @IBAction func passTFActoin(_ sender: UITextField) {
        
    }
    
    @IBAction func confPassTFActoin(_ sender: UITextField) {
        if let confPassText = sender.text,
           !confPassText.isEmpty,
           let passText = passwordTF.text,
           !passText.isEmpty {
            isConfPass = VerificationCervice.isPassConfirm(pass1: passText, pass2: confPassText)
        } else {
            isConfPass = false
        }
        /// Скроем валидац сообщение если введен корректный confPassText
        errorConfirmPassLbl.isHidden = isConfPass
    }
    
    
    
    
    
    
    
    
    private func startKeyboardObserver() {
        ///Нотификация на открытие клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        ///Нотификация на закрытие клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets ///Боковой скрол так же ограничить до клавиатуры
    }
    
    @objc private func keyboardWillHide() {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
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
