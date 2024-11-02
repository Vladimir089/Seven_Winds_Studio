//
//  RegisterViewController.swift
//  Seven_Winds_Studio
//
//  Created by Владимир Кацап on 02.11.2024.
//

import UIKit
import Combine

class AuthViewController: UIViewController {
    
    private lazy var mainView = AuthView(publisher: publisher)
    private lazy var authDataFlow = AuthDataFlow()
    private var isReg = true
    
    private let publisher = PassthroughSubject<Any, Never>()
    private lazy var cancellable = [AnyCancellable]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.title = "Регистрация"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
        mainView.frame = self.view.bounds
        addGestureInView()
        subscribe()
        addTargetInButton()
    }

    private func subscribe() {
        publisher
            .sink { _ in
                self.checkTexts()
            }
            .store(in: &cancellable)
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
        if arrTexts.contains(where: {$0 == ""}) {
            mainView.onAndOffAuthButton(isOn: false)
        } else {
            if isReg == true {
                if arrTexts[1] == arrTexts[2] {
                    mainView.onAndOffAuthButton(isOn: true)
                } else {
                    mainView.onAndOffAuthButton(isOn: false)
                }
            }
        }
        
        if !isReg {
            if arrTexts[0] != "" && arrTexts[1] != "" {
                mainView.onAndOffAuthButton(isOn: true)
            } else {
                mainView.onAndOffAuthButton(isOn: false)
            }
        }
  
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
