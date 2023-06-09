# MVVM-C_test
Repository designed to make architecture skeleton

Represents basic integration of MVVM + Coordinator using Combine and basic file structure.

Every ViewModel have Input and Output to manage all data goes in or may be subscribed.
For easy readability and similarity, to handle event from parrent, use eventHandler, 
else output should be used for controller to manage UI.

Coordinator same as ViewModel have eventHadler, to notify parrent Coordinator about next steps to manage flow.

