//
//  UserDefaultsService.swift
//  HWKurylenka_15_RegistrationApp
//
//

import Foundation

/// UserDefaults - это самая простая БД в IOS
/// Работает по принципу ключ-значение
/// БД очень медленная и предназначена для простых типов данных
/// Удаляется при удалении приложения
/// Работает по принципу Один к Одному

final class UserDefaultsService {
    /// Сохранение юзера
    static func saveUserModel(userModel: UserModel) {
        UserDefaults.standard.set(userModel.name, forKey: UserDefaults.Keys.name.rawValue)
        UserDefaults.standard.set(userModel.email, forKey: UserDefaults.Keys.email.rawValue)
        UserDefaults.standard.set(userModel.pass, forKey: UserDefaults.Keys.password.rawValue)
    }
    
    /// Получение юзера
    static func getUserModel()  -> UserModel? {
        
        let name = UserDefaults.standard.string(forKey: UserDefaults.Keys.name.rawValue)
        
        guard let email = UserDefaults.standard.string(forKey: UserDefaults.Keys.email.rawValue),
              let pass = UserDefaults.standard.string(forKey: UserDefaults.Keys.password.rawValue) else { return nil }
        /// Если все успешно пройдено то создать экземпляр UserModel
        let userModel = UserModel(name: name, email: email, pass: pass)
        return userModel
    }
    
    /// Удаление значений
    static func cleanUserDefaults() {
        UserDefaults.standard.reset()
    }
}
