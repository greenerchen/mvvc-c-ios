//
//  PopupCoordinator.swift
//  mvvm-c-ios
//
//  Created by Greener Chen on 2023/3/8.
//

import Foundation

protocol PopupCoordinatorDelegate: CoordinatorDelegate {
    func didFinishPopup()
}

class PopupCoordinator: Coordinator {
    
    weak var delegate: PopupCoordinatorDelegate?
    
    override func start() {
        let viewController = PopupViewController()
        viewController.navigationDelegate = self
        navigationController.viewControllers = [viewController]
    }
}

extension PopupCoordinator: PopupNavigationDelegate {
    func navigateToMain() {
        delegate?.didFinishPopup()
    }
}
