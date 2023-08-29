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

    
    
    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
