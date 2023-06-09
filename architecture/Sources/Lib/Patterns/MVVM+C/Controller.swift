import UIKit

/**
 You must implement this protocol on each UIViewController which is used in Coordinators.
 Due to current realization of MVVMC pattern, every controller must is initialized with its own ViewModel.
 
 Controller's roles:
 - define reusable View to display data from ViewModel
 - generate events for Coordinator about user's action
 
 There are also some typical protocols which you can implement on Controller:
 - RootViewGettable to get access to Controller's view
 - ActivityViewPresenter to show ActivityView
 - ControllerEventsSource to provide events for Coordinator
 - RequestResultsListener to handle state of intenet request
 - LogoutSignalSource to handle case when user's token has already outdated
 
 Controllers CAN NOT:
 - know about how to present itself
 - show other Controlers
 - modify any data defore presentation
 - request to internet or change Model state
 */

protocol Controller: AnyObject {
    
    associatedtype ViewModelType: ViewModel
    
    init(viewModel: ViewModelType)
    
    func configure(with viewModel: ViewModelType)
    
}
