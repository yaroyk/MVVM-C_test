//
//  SplashScreenViewModelImpl.swift
//  architecture
//
//  Created by photoyk on 08.06.2023.
//

import Combine
import Foundation

class SplashScreenViewModelImpl: SplashScreenViewModel {
    
    // MARK: - Subtypes
    
    struct Input: SplashScreenInput {
        var onAction: PassthroughSubject<SplashScreenAction, Never>
    }
    
    struct Output: SplashScreenOutput {
        var eventHandler: PassthroughSubject<SplashScreenEvent, Never>
    }
    
    // MARK: - Input and Output declarations
    
    lazy var input = Input(onAction: self.onAction)
    lazy var output = Output(eventHandler: self.eventHandler)
    
    // Input
    private let onAction = PassthroughSubject<SplashScreenAction, Never>()
    
    // Output
    private let eventHandler = PassthroughSubject<SplashScreenEvent, Never>()
    
    // MARK: - Private Properties
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Initializations and Deallocation
    
    init() {
        self.bind()
    }
}

// MARK: - Private

private extension SplashScreenViewModelImpl {
    func bind() {
        self.onAction
            .sink { [weak self] action in
                switch action {
                case .viewWillAppear:
                    self?.checkForUpdate()
                }
            }.store(in: &self.cancellables)
    }
    
    func checkForUpdate() {
        // Perform check for actual version of app allowed by back-end
        // than call toggleAppear()
        toggleAppear()
    }
    
    func toggleAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.eventHandler.send(.finished)
        }
    }
}
