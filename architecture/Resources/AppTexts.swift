//
//  AppTexts.swift
//  architecture
//
//  Created by photoyk on 08.06.2023.
//

import Foundation

// Prefered way to use SwiftGen for generation of safely unwraped objects

internal enum AppTexts {
    internal enum SplashScreen {
        internal static let title = "Architecture Example"
    }
    
    internal enum LoginScreen {
        internal static let title = "Login"
        internal static let emailPlaceholder = "Type you email here..."
        internal static let passwordPlaceholder = "Type you password here..."
        internal static let actionTitle = "Log me in"
    }
}
