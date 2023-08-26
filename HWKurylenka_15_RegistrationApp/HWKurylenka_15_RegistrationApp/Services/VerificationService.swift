//
//  VerificationService.swift
//  HWKurylenka_15_RegistrationApp
//
//

import Foundation

enum PasswordStreight {
    case veryWeak /// Данный кейс когда ни один из 4-х вью не светится
    case weak
    case notVeryWeak
    case notVeryStrong
    case strong
}

class VerificationCervice {
    
    /// Свойства на подсветку вью по уровню сложности пароля
    static let weakRegex          = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
    static let notVeyWeakRegex    = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d]{8,}$"
    static let notVeryStrongRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]]{8,}$"
    static let strongRegex        = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\dd$@$!%*#?&]{8,}$"
    
    /// Функция на проверку уровня сложности пароля. Возвращает Сложность
    static func isValidPassword (pass: String) -> PasswordStreight {
        if NSPredicate(format: "SELF MATCHES %@", strongRegex).evaluate(with: pass) {
            return.strong
        } else if NSPredicate(format: "SELF MATCHES %@", notVeryStrongRegex).evaluate(with: pass) {
            return.notVeryStrong
        } else if NSPredicate(format: "SELF MATCHES %@", notVeyWeakRegex).evaluate(with: pass) {
            return.notVeryWeak
        } else if NSPredicate(format: "SELF MATCHES %@", weakRegex).evaluate(with: pass) {
            return.weak
        } else {
            return.veryWeak
        }
    }
    
    
    
    
    /// Сделаем статические свойства
    static func isValidEmail (email: String) -> Bool {
        /// Для валидации почты. Забираем электронку
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}"
        /// Создаем объект типа NSPredicate, в котором будет проверяться уловие из emailRegEx
        let emaiPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        /// По предикату вызываем метод evaluate и вкидываем туда email
        return emaiPred.evaluate(with: email)
    }
    
    static func isPassConfirm(pass1: String, pass2: String) -> Bool {
        pass1 == pass2
    }
    
}



 
