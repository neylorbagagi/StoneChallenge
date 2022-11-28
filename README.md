# StoneChallenge

Join me on this Rick and Morty adventure and navigate through awesome characters.


## Architecture

### VIPER
For a modern and scalable approach, ***VIPER*** was chosen as the architecture pattern. The code is shared in 5 main artefacts: ViewModel, ViewController, Presenter, Interactor, Router and ViewControllerFactory.
This option works perfectly with protocols and makes tests easy and scalable, despite having a longer start.

---
### Networking

#### Image and Request cache
For concepts demonstration, I do make the option to use only native classes to manage ***REST*** requests and callbacks ***cache***. 
Native request

---
### Reactive Programming

#### RxSwift
Largely used in this project, ***RxSwift*** is a very practical and secure way to work with schedulers and threads.

---
#### Tests (in Progress)

#### Unit tests, Mocks and Stubs 
The code is monitored by the XCode ***Code Coverage*** feature that reports valuable information about sensible areas of code and coverage percentage. ***XCTest*** was used to assert the unit tests followed by ***mocks and stubs*** that improve the testability.

### SnapshotTesting
To check data disposition in landscape or portrait, the ***SnapshotTesting*** framework was used to visually check differences. 

---
### Interface

#### ViewCode and UIKit Code Preview 
The interface is built with ***ViewCode*** giving priority to ***UIStackViews*** and using the convenience ***SwiftUI preview*** class with ***UIKIt*** to request less build during the process.

---
#### Language Localization File
Another scalable feature is the usage of ***String Localization*** File evading the direct use of strings on views.

---
### Code Style and Dependencies Management

#### SwiftLint
The code style is preserved by ***SwiftLing*** lib and its dependencies are managed by ***Cocopods***.



