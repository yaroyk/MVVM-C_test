//
//  LoginScreenViewModel.swift
//  architecture
//
//  Created by photoyk on 08.06.2023.
//

import Combine
import Foundation

// MARK: - Actions
enum LoginScreenAction {
    case emailChanged(String?)
    case passwordChanged(String?)
    case performLogin
}

// MARK: - Events
enum LoginScreenEvent {
    case authed
}

protocol LoginScreenViewModel: ViewModel where Input: LoginScreenInput,
                                                Output: LoginScreenOutput { }

protocol LoginScreenInput {
    var onAction: PassthroughSubject<LoginScreenAction, Never> { get }
}

protocol LoginScreenOutput {
    var eventHandler: PassthroughSubject<LoginScreenEvent, Never> { get }
    var isLoading: AnyPublisher<Bool, Never> { get }
    var onError: AnyPublisher<String, Never> { get }
    var isLoginActive: AnyPublisher<Bool, Never> { get }
}
