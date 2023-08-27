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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        /// В infoLbl вкидываем значение, а если email не получили, то просто пустая строка будет " "
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
