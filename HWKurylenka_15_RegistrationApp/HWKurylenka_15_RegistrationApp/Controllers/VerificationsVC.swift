//
//  VerificationsVC.swift
//  HWKurylenka_15_RegistrationApp
//
//

import UIKit

class VerificationsVC: UIViewController {
    
    var userModel: UserModel? ///Делаем опциональным т.к. передаем с другого экрана
    
    ///Сделаем рандомное число
    let randomInt = Int.random(in: 100000 ... 999999)
    /// Таймер при неправильно введенном коде перед переходом на велком скрин
    var sleepTime = 3
    
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var codeTF: UITextField!
    @IBOutlet weak var wrongCodeLbl: UILabel!
    @IBOutlet weak var centerYConstraint: NSLayoutConstraint! ///Привязка констрейнта для поднятия клавиатуры
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        ///Уменьшить скрол на высоту клавиатуры
        startKeyboardObserver()
        ///Скрытие клавиатуры при нажатии на любом месте на экране
        hideKeyboardWhenTappedAround()
        /// Cообщение wrongCodeLbl изначально скрыто
        wrongCodeLbl.isHidden = true
        
    }
    
    @IBAction func codeTFAction(_ sender: UITextField) {
        wrongCodeLbl.isHidden = true
        guard let text = sender.text, !text.isEmpty,
            ///Сравнение текста с рандомным кодом и приведем код к String через description
              text == randomInt.description else {
            /// Если условия не соблюдаются, то отобразим сообщение wrongCodeLbl
            wrongCodeLbl.isHidden = false
            /// Логика таймера при неправильно введенном коде перед переходом на велком скрин
            sender.isUserInteractionEnabled = false /// Запрет ввода в текст филд codeTFAction
            wrongCodeLbl.text = "Wrong code. Please wait \(sleepTime) seconds" ///Замена сообщения на новое
            let dispatchAfter = DispatchTimeInterval.seconds(sleepTime) /// Создание задержки
            let deadLine = DispatchTime.now() + dispatchAfter /// Создание задержки
            DispatchQueue.main.asyncAfter(deadline: deadLine) {
                sender.isUserInteractionEnabled = true /// Обращение к текст филду и разблокировка его через интервал времени
                self.wrongCodeLbl.isHidden = true
                self.sleepTime *= 2 /// Увеличение временного интервала х2
            }
                return
            }
        performSegue(withIdentifier: "goToWelcomeScreen", sender: nil) /// В sender ничего не передаем
    }
    
    
    private func startKeyboardObserver() {
        ///Нотификация на открытие клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        ///Нотификация на закрытие клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        centerYConstraint.constant -= keyboardSize.height / 3 /// Поднимаем клавиатуру на половину высоты
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        centerYConstraint.constant += keyboardSize.height / 3 /// Опускаем клавиатуру на половину высоты
    }
    
    private func setupUI() {
        /// В infoLbl вкидываем значение, а если email не получили, то воспользуясь цепочкой опционалов поставим пустую строку  " "
        infoLbl.text = "Please enter code '\(randomInt)' from \(userModel?.email ?? "")"
    }
    
    
    // Mark: - Navigations
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? WelcomVC else { return }
        destVC.userModel = userModel
    }

}
