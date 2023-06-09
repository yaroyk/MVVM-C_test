/**
 Due to this realization of MVVMC pattern, every controller must have its own ViewModel.
 This protocol defines base behaviour for all Controllers. You must inherit and implement
 this protocol on your concrete view model.
 
 ViewModel's roles:
 - provide modified and prepeared data to display on Controller
 - incapsulate all actions like requests to internet or modifications of model layer
 - ViewModel's actions are accessible to Controller through ViewModel interface
 - Input type should contain observers (e.g. AnyObserver) that should be subscribed to UI elements that emit input events.
 - Output type should contain observables that emit events related to result of processing of inputs.
 
 ViewModels CAN NOT:
 - save Controller or any other View as property
 - modify or change Controller's state directly
 */

protocol ViewModel: AnyObject {
    associatedtype Input
    associatedtype Output
    var input: Input { get }
    var output: Output { get }
}
