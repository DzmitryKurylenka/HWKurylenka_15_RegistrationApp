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
    
    /// Свойства трех обязательных полей ввода + Активация кнопки Continue
    private var isValidEmail = false { didSet {updateContinueButtonState() }}
    private var isConfPass = false { didSet {updateContinueButtonState() }}
    private var passwordStreigth: PasswordStreight = .veryWeak { didSet {updateContinueButtonState() }} /// Сложность по умолчанию
    
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
        if let passText = sender.text,
           !passText.isEmpty {
            passwordStreigth = VerificationCervice.isValidPassword(pass: passText)
        } else {
            passwordStreigth = .veryWeak ///Если не сможем вытащить пароль ставим сложность veryWeak
        }
        /// Скроем валидац сообщение если введен корректный passText
        weakPasswordLbl.isHidden = passwordStreigth != .veryWeak
        /// Подключим индикаторы сложности пароля
        setupStrongIndicatorsViews()
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
    
    @IBAction func signInAction() {
        navigationController?.popToRootViewController(animated: true) /// Возврат на 1 экран
//        navigationController?.popViewController(animated: true) /// Возврат на пред экран
    }
    /// Предварительно создаем UserModel
    @IBAction func continueAction() {
        if let email = emailTF.text,
           let pass = passwordTF.text {
            let userModel = UserModel(name: nameTF.text, email: email, pass: pass)
            performSegue(withIdentifier: "goToVerifScreen", sender: userModel)
        }
    }
    
    
    private func setupStrongIndicatorsViews() {
        
//        for (index, view) in strongPassIndicatorsViews.enumerated() {
//            if index <= (passwordStreigth.rawValue - 1) {
//                view.alpha = 1
//            } else {
//                view.alpha = 0.2
//            }
//        }
        /// Тоже самое через forEach
        strongPassIndicatorsViews.enumerated().forEach { index, view in
            if index <= (passwordStreigth.rawValue - 1) {
                view.alpha = 1
            } else {
                view.alpha = 0.2
            }
        }
    }
    
    /// Активация кнопки Continue
    private func updateContinueButtonState() {
        continueBtn.isEnabled = isValidEmail && isConfPass && passwordStreigth != .veryWeak
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

    
    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? VerificationsVC,
              let userModel = sender as? UserModel
        else { return }
        destVC.userModel = userModel
    }
}
