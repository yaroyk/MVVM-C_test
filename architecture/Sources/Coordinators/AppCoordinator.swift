//
//  AppCoordinator.swift
//  architecture
//
//  Created by photoyk on 08.06.2023.
//

import Combine
import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: - Properties

    private let window: UIWindow
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private var cancellables: Set<AnyCancellable> = []
    
    let splashScreen: (SplashScreenViewModelImpl) -> SplashScreenViewController<SplashScreenViewModelImpl>
    let authCoordinator: (UINavigationController) -> AuthFlowCoordinator
    
    // MARK: - Initializations and Deallocation
    
    init(window: UIWindow) {
        let navController = UINavigationController()
        navController.navigationBar.barStyle = .default
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.isHidden = false
        
        self.window = window
        self.window.rootViewController = navController
        self.window.makeKeyAndVisible()
        
        self.navigationController = navController
    }
    
    // MARK: - Public
    func start(_ completion: @escaping () -> Void) {
        startSplashScreen()
    }
    
    // MARK: - Private
    private func defineLogin() {
        // Check keychain for auth status to define flow
        
        /// Example variable authed can be changed to switch flow below
        /// Need to be replaced with parameter from local repository or storage
        let authed = false
        
        if authed {
            startAuthCoordinator()
        } else {
            startMainCoordinator()
        }
    }
    
    // MARK: - Splash Screen
    private func startSplashScreen() {
        let viewModel = SplashScreenViewModelImpl()
        let controller = splashScreen(viewModel)
        
        viewModel.output.eventHandler
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                switch event {
                case .finished:
                    self?.defineLogin()
                }
            }.store(in: &cancellables)
        
        navigationController.setViewControllers([controller], animated: false)
    }
    
    // MARK: - Auth
    private func startAuthCoordinator() {
        let coordinator = authCoordinator(navigationController)
        
        coordinator.eventHandler
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                switch event {
                case .authorizationPassed:
                    self?.startMainCoordinator()
                    self?.removeChildCoordinator(coordinator)
                }
            }.store(in: &cancellables)
    
        addChildCoordinator(coordinator)
        coordinator.start {}
    }
    
    // MARK: - Main Flow
    private func startMainCoordinator() {
        let coordinator = authCoordinator(navigationController)
        
        coordinator.eventHandler
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                switch event {
                case .authorizationPassed:
                    self?.startMainCoordinator()
                    self?.removeChildCoordinator(coordinator)
                }
            }.store(in: &cancellables)
    
        addChildCoordinator(coordinator)
        coordinator.start {}
    }
    
    private func logOut() {
        self.navigationController.viewControllers = []
        self.defineLogin()
    }
}
