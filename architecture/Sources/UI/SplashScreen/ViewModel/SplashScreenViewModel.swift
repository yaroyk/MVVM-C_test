//
//  SplashScreenViewModel.swift
//  architecture
//
//  Created by photoyk on 08.06.2023.
//

import Combine
import Foundation

// MARK: - Actions
enum SplashScreenAction {
    case viewWillAppear
}

// MARK: - Events
enum SplashScreenEvent {
    case finished
}

protocol SplashScreenViewModel: ViewModel where Input: SplashScreenInput,
                                                Output: SplashScreenOutput { }

protocol SplashScreenInput {
    var onAction: PassthroughSubject<SplashScreenAction, Never> { get }
}

protocol SplashScreenOutput {
    var eventHandler: PassthroughSubject<SplashScreenEvent, Never> { get }
}
