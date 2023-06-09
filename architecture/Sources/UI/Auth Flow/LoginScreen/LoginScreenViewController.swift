//
//  LoginScreenViewController.swift
//  architecture
//
//  Created by photoyk on 08.06.2023.
//

import Combine
import CombineCocoa
import UIKit

class LoginScreenViewController<T: LoginScreenViewModel>: UIViewController,
                                                          Controller {
    
    // MARK: - Typealias
    typealias ViewModel = T
    
    // MARK: - IBOutlets
    @IBOutlet weak var inputContainer: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Properties
    private var cancellables: Set<AnyCancellable> = []
    private let viewModel: ViewModel
    
    // Layout config
    private let cornerRadius: CGFloat = 8
    
    // MARK: - Initializations and Deallocation
    deinit {
        print("Controller deinit: \(type(of: self))")
    }
    
    required init(viewModel: ViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: classNameForXib(Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Configure
    func configure(with viewModel: ViewModel) {}
    
    private func bind() {
        emailTextField.textPublisher
            .map { LoginScreenAction.emailChanged($0) }
            .subscribe(viewModel.input.onAction)
            .store(in: &cancellables)
        
        passwordTextField.textPublisher
            .map { LoginScreenAction.passwordChanged($0) }
            .subscribe(viewModel.input.onAction)
            .store(in: &cancellables)
        
        loginButton.tapPublisher
            .map { LoginScreenAction.performLogin }
            .subscribe(viewModel.input.onAction)
            .store(in: &cancellables)
    }
    
    // MARK: - Private
    private func setupUI() {
        setupInputContainer()
        
        loginButton.configuration = .borderedProminent()
        loginButton.setTitle(AppTexts.LoginScreen.actionTitle,
                             for: .normal)
    }
    
    private func setupInputContainer() {
        inputContainer.set(corners: .allCorners, radius: cornerRadius)
        inputContainer.addShadow(color: UIColor.black.withAlphaComponent(0.2),
                                 radius: cornerRadius)
        
        emailTextField.placeholder = AppTexts.LoginScreen.emailPlaceholder
        passwordTextField.placeholder = AppTexts.LoginScreen.passwordPlaceholder
    }
}

