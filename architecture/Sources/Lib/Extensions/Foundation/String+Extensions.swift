//
//  String+Extensions.swift
//  architecture
//
//  Created by photoyk on 08.06.2023.
//

import Foundation

// MARK: Validation
extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self) && !self.contains(" ")
    }
    
    func isValidPassword() -> Bool {
        // Only checks for allowed characters
        let containsCorrectSymbolsRegEx = "^[A-Z0-9a-z-.%+,?!&<>#*~$\\@]{1,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", containsCorrectSymbolsRegEx)
        
        return passwordTest.evaluate(with: self) && !self.contains(" ")
    }
}

// MARK: - Check for empty text fields
extension String {
    /// True if string contains only newlines or whitespaces, or is empty
    var isBlank: Bool { trimmed.isEmpty }
    var trimmed: String { self.trimmingCharacters(in: .whitespacesAndNewlines) }
    var isPresent: Bool { !isBlank }
}
