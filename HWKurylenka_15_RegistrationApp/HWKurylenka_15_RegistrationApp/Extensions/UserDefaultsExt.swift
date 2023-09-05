//
//  UserDefaultsExt.swift
//  HWKurylenka_15_RegistrationApp
//
//

import Foundation

extension UserDefaults {
    /// CaseIterable - протокол, позволяющий enum (Keys) превратить в массив типа [String]
    enum Keys: String, CaseIterable {
        case email
        case name
        case password
    }
    ///  Сделаем функцию, которая будет удалять все элементики в UserDefaults по ключам
    func reset () {
        let allCases = Keys.allCases
        allCases.forEach { removeObject(forKey: $0.rawValue)
        }
    }
}
