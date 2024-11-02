//
//  AuthView.swift
//  Seven_Winds_Studio
//
//  Created by Владимир Кацап on 02.11.2024.
//

import UIKit
import SnapKit
import Combine

class AuthView: UIView {
    
    let publisher: PassthroughSubject<Any, Never>
    var isReg = true
    
    //MARK: -Email
    private let emailLabel = StaticClass.createTitleLabel(text: "e-mail")
    private lazy var emailTextField = StaticClass.createTextField(placeholder: "example@example.ru", isPassword: false, delegate: self)
    
    //MARK: -Password
    private let passwortFirstLabel = StaticClass.createTitleLabel(text: "Пароль")
    private lazy var passwordFirstTextField = StaticClass.createTextField(placeholder: "*****", isPassword: true, delegate: self)
    private let passwortSecondLabel = StaticClass.createTitleLabel(text: "Повторите пароль")
    private lazy var passwordSecondTextField = StaticClass.createTextField(placeholder: "*****", isPassword: true, delegate: self)
    
    //MARK: -Button auth
    private let authButton = StaticClass.createBrownButton(title: "Регистрация")
    
    //MARK: -Other
    private lazy var stackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: createSubViews())
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .white
        return stackView
    }()
    

    init(publisher: PassthroughSubject<Any, Never>) {
        self.publisher = publisher
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(249)
        }
        
        addSubview(authButton)
        authButton.isEnabled = false
        authButton.alpha = 0.5
        authButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(stackView.snp.bottom).inset(-30)
            make.height.equalTo(47)
        }
    }
    
    private func createSubViews() -> [UIView] {
        let textFieldsArr = [emailTextField, passwordFirstTextField, passwordSecondTextField]
        let labelsArr = [emailLabel, passwortFirstLabel, passwortSecondLabel]
            
        var arr: [UIView] = []
        
        for index in 0..<textFieldsArr.count {
            let view = UIView()
            view.backgroundColor = .clear
            view.addSubview(labelsArr[index])
            labelsArr[index].snp.makeConstraints { make in
                make.left.equalToSuperview().inset(15)
                make.top.equalToSuperview()
            }
            
            view.addSubview(textFieldsArr[index])
            textFieldsArr[index].snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(15)
                make.height.equalTo(47)
                make.top.equalTo(labelsArr[index].snp.bottom).inset(-10)
            }
            arr.append(view)
        }
        return arr
    }
    
    func returnTexts() -> [String] {
        return [emailTextField.text ?? "", passwordFirstTextField.text ?? "", passwordSecondTextField.text ?? ""]
    }
    
    func onAndOffAuthButton(isOn: Bool) {
        authButton.isEnabled = isOn
        UIView.animate(withDuration: 0.3) {
            self.authButton.alpha = isOn ? 1 : 0.5
        }
    }
    
    func upAndDownStackView(isUp: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.stackView.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(isUp ? -150 : 0)
            }
            self.layoutIfNeeded()
        }
    }
    
    func returnButton() -> UIButton {
        return authButton
    }
    
    func failRegOrLogin() {
        authButton.isEnabled = false
        UIView.animate(withDuration: 0.3) {
            self.authButton.backgroundColor = .red
            self.authButton.setTitle("Ошибка", for: .normal)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            UIView.animate(withDuration: 0.3) {
                self.authButton.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.1764705882, blue: 0.1019607843, alpha: 1)
                self.authButton.setTitle(self.isReg ? "Регистрация" : "Войти", for: .normal)
                self.authButton.isEnabled = true
            }
        }
    }
    
    func changeToLogin() {
        let arr = [emailTextField, passwordFirstTextField]
        for i in arr {
            i.text = ""
        }
        
        if let lastSubview = stackView.arrangedSubviews.last {
            stackView.removeArrangedSubview(lastSubview)
            lastSubview.removeFromSuperview()
        }
        
        UIView.animate(withDuration: 0.3) {
            self.stackView.snp.updateConstraints { make in
                make.height.equalTo(176)
            }
            self.passwortSecondLabel.alpha = 0
            self.passwordSecondTextField.alpha = 0
            self.authButton.setTitle("Войти", for: .normal)
            self.layoutIfNeeded()
        }
        
    }
    
}

extension AuthView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.publisher.send(1)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.publisher.send(1)
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.publisher.send(1)
    }
}
