import Foundation
import UIKit

/**
 MVVMC is base pattern on the project. There are several actors:
 - Model - data container or persistent object.
 - View - object to represent data on UI. You must inherite Cotroller type to use it as View.
 - ViewModel - object to incapsulate logic from visualization.
 - Coordinator - entity to manage all Controller's and sub-coordinators
 
 Coordinator's roles:
 - incapsulate dependencies
 - provide dependency injection role
 - init ViewModels
 - init Controllers with ViewModel
 - show and hide Controllers (in stack, modally or in any another way)
 - subscribe on Controller's events and react on events
 - show\hide sub-coordinators if needed
 - subscribe on ViewModel's updates
 
 Coordinator CAN NOT:
 - save any Controller or ViewModel as property
  */
protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get }
    func start(_ completion: @escaping () -> Void)
}

extension Coordinator {
    public func addChildCoordinator(_ childCoordinator: Coordinator) {
        self.childCoordinators.append(childCoordinator)
    }
    
    public func removeChildCoordinator(_ childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    }
}
