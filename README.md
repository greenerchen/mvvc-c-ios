# MVVM-C-iOS
This project is to implement the MVVM-C (Model-View-ViewModel-Coordinator) architecutre pattern in an iOS app.
The Coordinator pattern was introduced by [Soroush Khanlou](http://khanlou.com/) at the NSSpain conference in 2015. I use the following pieces to learn more about the Coordinator pattern:
- ["Presenting Coordinators" by Soroush Khanlou](https://vimeo.com/144116310)
- ["Navigation in Swift" by John Sundell](https://www.swiftbysundell.com/articles/navigation-in-swift/)

# Architecture
![Coordinator](https://user-images.githubusercontent.com/1248888/223585328-338bfdf5-b464-4a84-9a44-683d1daee40b.png)

## Navigation
A coordinator owns a navigation controller to present view controllers, that has a delegate reference to the coordinator to call delegate methods for naviagations. Each coordinator use the `start()` function to present its view controller(s). A coordinator also owns an array of children coordinator to present another navigation flow managed by its child coordinator.
```Swift
import UIKit

protocol Coordinator {
  var children: [Coordinator] { get set }
  init(navigationController: UINavigationController)
  func start()
}

class AppCoordinator: Coordinator {
  var children: [Coordinator]
  let navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let vc1 = ViewController1()
    vc1.navigationDelegate = self
    navigationController.pushViewController(vc1, animated: true)
  }
}

extension AppCoordinator: MainViewControllerNavigationDelegate {
  func navigateToViewController1() {
    navigationController.popToRootViewController(animated: true)
  }
  
  func navigateToViewController2() {
    let vc2 = ViewController2()
    vc2.navigationDelegate = self
    navigationController.pushViewController(vc2, animated: true)
  }
}
```

## Presentation
Each view controller has a delegate reference to its coordinator to separate navigation logics, besides handling presentation with data binding through its view model.
```Swift
import UIKit

protocol MainViewControllerNavigationDelegate: AnyObject {
  func navigateToViewController1()
  func navigateToViewController2()
  func navigateToLogin()
}

class ViewController1: UIViewController {
  weak var navigationDelegate: MainViewControllerNavigationDelegate?
  ...
  
  @objc
  func didTapShowVC2() {
    navigationDelegate?.navigateToViewController2()
  }
  
  @objc
  func didTapLogin() {
    navigationDelegate?.navigateToLogin()
  }
}

class ViewController2: UIViewController {
  weak var navigationDelegate: MainViewControllerNavigationDelegate?
  ...
  
  @objc
  func didTapShowVC1() {
    navigationDelegate?.navigateToViewController1()
  }
}
```
## Business Logics
View models and other service, worker components handles business logics.


Say there is another login flow managed by `LoginCoordinator`. When a user taps the login button from ViewController1, it will trigger `AppCoordinator` to create `LoginCoordinator` and present `LoginViewController`. Afterwards, the user finish the login flow by calling the delgate method `loginDidFinish`, and it will trigger `AppCoordinator` to dismiss the login flow presentation and remove `LoginCoordinator` from its children coordinators.

```Swift
extension AppCoordinator: MainViewControllerNavigationDelegate {
  func navigateToLogin() {
    let loginCoordinator = LoginCoordinator(navigationController: UINavigationController())
    loginCoordinator.delegate = self
    children.append(loginCoordinator)
    loginCoordinator.start()
  }
}

protocol LoginCoordinatorDelegate {
  func loginDidFinish()
}

extension AppCoordinator: LoginCoordinatorDelegate {
  func loginDidFinish() {
    navigationController.popViewController(animated: true)
    children.removeLast()
  }
}

class LoginCoordinator: Coordinator {
  var children: [Coordinator]
  weak var delegate: LoginCoordinatorDelegate?
  let navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let vc = LoginViewController()
    vc.navigationDelegate = self
    navigationController.pushViewController(vc, animated: true)
  }
}

extention LoginCoordinator: LoginViewControllerNavigationDelegate {
  func navigateToFacebookLogin() {
    ...
  }
  func navigateToMain() {
    delegate?.loginDidFinish()
  }
}

protocol LoginViewControllerNavigationDelegate: AnyObject {
  func navigateToFacebookLogin()
  func navigateToMain()
}

class LoginViewController: UIViewController {
  weak var navigationDelegate: LoginViewControllerNavigationDelegate?
  ...
  
  @objc
  func didTapLogin() {
    navigationDelegate?.navigateToFacebookLogin()
  }
  
  func didFinishLogin() {
    navigationDelegate?.navigateToMain()
  }
}
```
