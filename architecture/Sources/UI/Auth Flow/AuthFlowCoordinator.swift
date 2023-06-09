//
//  AuthFlowCoordinator.swift
//  architecture
//
//  Created by photoyk on 08.06.2023.
//

import Combine
import Foundation
import UIKit

// MARK: - Events
enum AuthFlowCoordinatorEvent {
    case authorizationPassed
}

// MARK: - DIC Controller factories
struct AuthFlowCoordinatorFactory {
    let loginScreen: (LoginScreenViewModelImpl) -> LoginScreenViewController<LoginScreenViewModelImpl>
}

final class AuthFlowCoordinator: Coordinator {
    
    // MARK: - Controllers Factories
    private let controllerFactory: AuthFlowCoordinatorFactory
    
    // MARK: - Properties
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    var eventHandler = PassthroughSubject<AuthFlowCoordinatorEvent, Never>()
    var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Initializations and Deallocation
    init(navigationController: UINavigationController, controllerFactory: AuthFlowCoordinatorFactory) {
        self.navigationController = navigationController
        self.controllerFactory = controllerFactory
    }
    
    deinit {
        print("Coordinator deinit: \(type(of: self))")
    }
    
    // MARK: - Public
    func start(_ completion: @escaping () -> Void) {
        self.presentLogin()
    }
    
    // MARK: - Login Screen
    private func presentLogin() {
        let viewModel = LoginScreenViewModelImpl()
        let controller = controllerFactory.loginScreen(viewModel)
        
        viewModel.output.eventHandler
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                switch event {
                case .authed:
                    self?.eventHandler.send(.authorizationPassed)
                }
            }.store(in: &cancellables)
        
        self.navigationController.setViewControllers([controller], animated: false)
    }
}
