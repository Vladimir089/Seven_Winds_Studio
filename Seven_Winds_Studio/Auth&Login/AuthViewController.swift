//
//  RegisterViewController.swift
//  Seven_Winds_Studio
//
//  Created by Владимир Кацап on 02.11.2024.
//

import UIKit

protocol AuthViewControllerDelegate: AnyObject {
    func checkText()
}


class AuthViewController: UIViewController {
    
    private lazy var mainView = AuthView()
    private lazy var authDataFlow = AuthDataFlow()
    private var isReg = true
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.title = "Регистрация"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
        mainView.delegate = self
        addGestureInView()
        addTargetInButton()
    }

   
    
    private func addGestureInView() {
        let hideKBgesture = UITapGestureRecognizer(target: self, action: #selector(hideKB))
        view.addGestureRecognizer(hideKBgesture)
    }
    
    @objc private func hideKB() {
        self.view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        self.mainView.upAndDownStackView(isUp: true)
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        self.mainView.upAndDownStackView(isUp: false)
        checkTexts()
    }
    
    private func checkTexts() {
        let arrTexts = mainView.returnTexts()
        if arrTexts.contains(where: { $0.isEmpty }) {
            mainView.onAndOffAuthButton(isOn: false)
            return
        }
        
        if isReg {
            if arrTexts[1] == arrTexts[2], isPasswordValid(arrTexts[1]) {
                mainView.onAndOffAuthButton(isOn: true)
            } else {
                mainView.onAndOffAuthButton(isOn: false)
            }
        } else {
            if !arrTexts[0].isEmpty && isPasswordValid(arrTexts[1]) {
                mainView.onAndOffAuthButton(isOn: true)
            } else {
                mainView.onAndOffAuthButton(isOn: false)
            }
        }
    }
    
    private func isPasswordValid(_ password: String) -> Bool {
        let minLength = 6
        let uppercaseLetter = NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*")
        let lowercaseLetter = NSPredicate(format: "SELF MATCHES %@", ".*[a-z]+.*")
        let digit = NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*")
        
        return password.count >= minLength &&
               uppercaseLetter.evaluate(with: password) &&
               lowercaseLetter.evaluate(with: password) &&
               digit.evaluate(with: password)
    }
    
    private func addTargetInButton() {
        let button = mainView.returnButton()
        button.removeTarget(nil, action: nil, for: .allEvents)
        button.addTarget(self, action: isReg ? #selector(addRegTarget) : #selector(addLogintarget), for: .touchUpInside)
    }
    
    @objc private func addRegTarget() {
        let arrTexts = mainView.returnTexts()
        authDataFlow.registerUser(login: arrTexts[0], password: arrTexts[1], isReg: true) { result,_  in
            if result == true {
                self.changeToLogin()
                self.addTargetInButton()
            } else {
                self.mainView.failRegOrLogin()
            }
        }
    }
    
    
    
    @objc private func addLogintarget() {
        let arrTexts = mainView.returnTexts()
        authDataFlow.registerUser(login: arrTexts[0], password: arrTexts[1], isReg: false) { result,data  in
            if result == true && data != nil {
                UserDefaults.standard.setValue(data?.token, forKey: "token")
                self.navigationController?.setViewControllers([MainCofeViewController()], animated: true)
            } else {
                self.mainView.failRegOrLogin()
            }
        }
    }
    
    private func changeToLogin() {
        isReg = false
        mainView.isReg = isReg
        mainView.changeToLogin()
        self.title = "Вход"
    }
    
    
}


extension AuthViewController: AuthViewControllerDelegate {

    func checkText() {
        self.checkTexts()
    }

}
