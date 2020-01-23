//
//  LoginViewController.swift
//  ReactiveHomeWork
//
//  Created by Александр Арсенюк on 09.11.2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class LoginViewController: UIViewController {
    //MARK: - Variables

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var helpLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var helpLabelHeight: NSLayoutConstraint!
    
    //MARK: - Constants
    
    let disposeBag = DisposeBag()
    let viewModel: LoginViewModelDelegate = LoginViewModel()
    
    private struct Constants {
        static var loginTextFieldPlaceholder = "Введите логин"
        static var passwordTextFieldPlaceholder = "Введите пароль"
    }
    //MARK: - Lificycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    //MARK: - Configure Methods
    
    private func configureViews() {
        
        configureView()
        configureLoginTextField()
        configurePasswordTextField()
        configureHelpLabel()
        configureErrorLabel()
        configureBinding()
    }
    
    private func configureView() {
        
        configureGradient()
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    private func configureGradient() {
        
        let gradientLayer = CAGradientLayer()
        let topColor = UIColor.yellow.withAlphaComponent(0.7)
        let bottomColor = UIColor.orange.withAlphaComponent(0.7)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.frame = view.frame
        gradientLayer.locations = [0, 1]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func configureLoginTextField() {
        
        loginTextField.placeholder = Constants.loginTextFieldPlaceholder
        loginTextField.returnKeyType = .done
    }
    
    private func configurePasswordTextField() {
        
        passwordTextField.placeholder = Constants.passwordTextFieldPlaceholder
        passwordTextField.returnKeyType = .go
        passwordTextField.isSecureTextEntry = true
    }
    
    private func configureHelpLabel() {
        
        helpLabel.numberOfLines = 3
        helpLabel.text = "user1  123456\nuser2  qwerty\nuser3 password"
        helpLabel.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        helpLabel.textAlignment = .center
    }
    
    private func configureErrorLabel() {
        
        errorLabel.text = ""
        errorLabel.font = UIFont.systemFont(ofSize: 17.0)
        errorLabel.textAlignment = .center
    }
    
    //MARK: - Reactive
    
    private func configureBinding() {
        
        loginTextField.rx.text.orEmpty
            .bind(to: viewModel.login)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        /// Действие при нажатии на return key поля логина
        loginTextField.rx.controlEvent(.editingDidEndOnExit).asObservable().bind {
            self.passwordTextField.becomeFirstResponder()
        }.disposed(by: disposeBag)
    
        /// Действие при нажатии на return key поля пароля
        passwordTextField.rx.controlEvent(.editingDidEndOnExit).asObservable().bind {
            self.viewModel.validateUser()
        }.disposed(by: disposeBag)
        
        
        /// Действие при ошибке
        viewModel.errorValue.skip(1).asObservable().bind { [unowned self] error in
            self.errorLabel.text = error
        }.disposed(by: disposeBag)
        
        /// Действие если залогинились успешно
        viewModel.isSuccess.skip(1).asObservable().bind() { [unowned self] success in
            if success {
                self.presentListViewController()
            }
        }.disposed(by: disposeBag)
        
    }
        
//MARK: - Navigation
    
    private func presentListViewController() {
        
        let  mainView = UIStoryboard(name:"Main", bundle: nil)
        let viewController : UIViewController = mainView.instantiateViewController(withIdentifier: "listNavBar") as! UINavigationController
        UIApplication.shared.windows.first?.rootViewController = viewController
    }
}
