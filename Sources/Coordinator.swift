//
//  mvvm_c_ios.swift
//  mvvm-c-ios
//
//  Created by Greener Chen on 2023/3/8.
//

import UIKit

protocol Coordinatable: AnyObject {
    var children: [Coordinatable] { get set }
    init(navigationController: UINavigationController)
    func start()
}

protocol CoordinatorDelegate: AnyObject {}

class Coordinator: Coordinatable {
    var children: [Coordinatable] = []
    
    /// To add a delegate into every coordinator except `AppCoordinator`
//    weak var delegate: CoordinatorDelegate?
    
    let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        fatalError("func start() has not been implemented")
    }
    
    func attachChild(_ child: Coordinatable) {
        children.append(child)
    }
    
    func detachChild(_ child: Coordinatable) {
        children.removeAll(where: { $0 === child })
    }
}
