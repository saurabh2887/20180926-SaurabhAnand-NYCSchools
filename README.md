Architecture
--------------------------

This Application follows MVVM design pattern. This way all the model manipulation service calls can be handled from viewModel.
View controllers will be just for UI and less coupled with Model.

Created singleton network manager for maintainability and extensibility for the newtork layer for any service calls and JSON parsing

Models are used for setting up the attributes coming from response.

View Controllers for handling the view.

Unit testing for testing service calls and view model.

Compatible with Xcode 10 and iPhoneX

Installation
--------------------------

Carthage:

Easy to install and download the thrd party framework
Install [Carthage](https://github.com/Carthage/Carthage):

`brew install carthage`
carthage update/bootstrap

Carthage is used as dependency manager by default.

Alamofire:

Used for service api calls and json pasring and passing the response to view model through network layer
Easy to use and flexibilty with the rest service api and handling of the json response.


Improvement
--------------------------

Better way to handle constants
Include UI testing.

Built with
--------------------------
Cartahge - Dependecy Management system


Author
--------------------------

Saurabh Anand,
saurabh2887@gmail.com

