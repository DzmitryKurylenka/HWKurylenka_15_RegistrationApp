//
//  UIViewControllerExt.swift
//  HWKurylenka_15_RegistrationApp
//
//

import UIKit
///Сделав этот метод в расширениях, есть возможность его вызывать на любом экране (использовать эту логику)
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
