//
//  LoginScreenViewModelImpl.swift
//  architecture
//
//  Created by photoyk on 08.06.2023.
//

import Combine
import Foundation

class LoginScreenViewModelImpl: LoginScreenViewModel {
    
    // MARK: - Subtypes
    struct Input: LoginScreenInput {
        var onAction: PassthroughSubject<LoginScreenAction, Never>
    }
    
    struct Output: LoginScreenOutput {
        var eventHandler: PassthroughSubject<LoginScreenEvent, Never>
        var isLoading: AnyPublisher<Bool, Never>
        var onError: AnyPublisher<String, Never>
        var isLoginActive: AnyPublisher<Bool, Never>
    }
    
    // MARK: - Input and Output declarations
    lazy var input = Input(onAction: onAction)
    lazy var output = Output(eventHandler: eventHandler,
                             isLoading: isLoading,
                             onError: onError,
                             isLoginActive: isLoginActive)
    
    // Input
    private let onAction = PassthroughSubject<LoginScreenAction, Never>()
    
    // Output
    private let eventHandler = PassthroughSubject<LoginScreenEvent, Never>()
    
    @Published private var error: String?
    var onError: AnyPublisher<String, Never> {
        $error.compactMap({ $0 }).eraseToAnyPublisher()
    }
    
    @Published private var _isLoading: Bool = false
    var isLoading: AnyPublisher<Bool, Never> {
        $_isLoading.eraseToAnyPublisher()
    }
    
    @Published private var _isLoginActive: Bool = false
    var isLoginActive: AnyPublisher<Bool, Never> {
        $_isLoginActive.eraseToAnyPublisher()
    }
    
    // MARK: - Private Properties
    private var cancellables: Set<AnyCancellable> = []
    
    @Published private var email: String?
    @Published private var password: String?
    
    // MARK: - Initializations and Deallocation
    init() {
        // repository for networking should be injected here
        self.bind()
    }
}

// MARK: - Private

private extension LoginScreenViewModelImpl {
    func bind() {
        self.onAction
            .sink { [weak self] action in
                switch action {
                case .emailChanged(let value):
                    self?.email = value
                case .passwordChanged(let value):
                    self?.password = value
                case .performLogin:
                    self?.performLogin()
                }
            }.store(in: &self.cancellables)
        
        Publishers.CombineLatest($email, $password)
            .map { email, password in
                guard
                    let emailValue = email,
                    let passwordValue = password
                else { return false }
                
                let isEmailValid = emailValue.isValidEmail() && !emailValue.isBlank
                let isPasswordValid = passwordValue.isValidPassword() && !passwordValue.isBlank
                
                return isEmailValid && isPasswordValid
            }
            .sink { [weak self] in
                self?._isLoginActive = $0
            }
            .store(in: &cancellables)
    }
    
    func performLogin() {
        // Add repository call to login user
        // in case of error -> assign message to error
        // for example purposes just calling eventHandler as authed
        eventHandler.send(.authed)
    }
}
