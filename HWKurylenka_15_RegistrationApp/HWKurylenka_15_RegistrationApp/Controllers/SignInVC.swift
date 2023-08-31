//
//  SignInVC.swift
//  HWKurylenka_15_RegistrationApp
//
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
    @IBOutlet weak var centerYConstraint: NSLayoutConstraint!
    
    /// Отрабатывает единожды
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupUI()
        
        /// В идеале в UserDefaults нужно записать булево значение залогирован ли пользователь
        /// Если смогли получить UserModel, то будем проваливаться внутрь приложения
        /// (т.е. если мы предварительно уже логинились, то будем сразу при следующем старте приложения попадать внутрь приложения)
        if let _ = UserDefaultsService.getUserModel() {
            goToTabBarController()
        }
        
    }
    
    /// Этот метод вызывается перед каждым появлением этого экрана
    /// В этом методе будут зачищаться данные
    override func viewWillAppear(_ animated: Bool) {
        emailTF.text = ""
        passTF.text = ""
    }
    
    @IBAction func signInAction() {
        incorrectLbl.isHidden = true
        /// Забираем email и pass из полей
        guard let email = emailTF.text,
              let pass = passTF.text,
              /// Вытаскиваем данные из UserDefaultsService
              let userModel = UserDefaultsService.getUserModel(),
              /// Сравнение email с email, кот вытащили из UserDefaultsService
              email == userModel.email,
              /// Сравнение pass с pass, кот вытащили из UserDefaultsService
              pass == userModel.pass
        else {
            /// Иначе отобразим incorrectLbl
            incorrectLbl.isHidden = false
            return
        }
        
        goToTabBarController()
    }
    
    private func goToTabBarController() {
        /// Если все ОК то переходим на следующий VC
        let storyBoard = UIStoryboard(name: "MainStoryboard", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
//    private func setupUI() {
//        ///Сделать кнопку signIn неактивной
//        signInBtn.isEnabled = false
//    }
}


// ------
///Продолжение нашего класса
///В  Extension могут быть только методы
extension SignInVC {
}
// ------



