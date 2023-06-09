//
//  Functions.swift
//  architecture
//
//  Created by photoyk on 08.06.2023.
//

import Foundation

///  Get String description of any needed class
/// - Parameter cls: Any Class to describe
/// - Returns:  String description as class name
func toString(_ cls: AnyClass) -> String {
    return String(describing: cls)
}

func classNameAsString(_ obj: Any) -> String {
  return String(describing: type(of: obj))
}

///  Get String description of controller with generic type
/// - Parameter cls: Any controller with generic type
/// - Returns:  String description of controller without <Generic type> 
func classNameForXib(_ obj: Any) -> String {
  let name = String(describing: type(of: obj)).components(separatedBy: "<")
  if let className = name.first {
    return className
  } else {
    fatalError("No class name can be found")
  }
}
