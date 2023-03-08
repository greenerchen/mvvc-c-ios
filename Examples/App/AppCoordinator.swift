//
//  AppCoordinator.swift
//  mvvm-c-ios
//
//  Created by Greener Chen on 2023/3/8.
//

import UIKit

class AppCoordinator: Coordinator {
    override func start() {
        let viewController = MainViewController()
        viewController.navigationDelegate = self
        navigationController.viewControllers = [viewController]
    }
}

extension AppCoordinator: MainNavigationDelegate {
    func navigateToDetail() {
        let viewController = DetailViewController()
        viewController.navigationDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func navigateToPopup() {
        let popupCoordinator = PopupCoordinator(navigationController: UINavigationController())
        popupCoordinator.delegate = self
        attachChild(popupCoordinator)
        popupCoordinator.start()
        navigationController.viewControllers.last?.present(popupCoordinator.navigationController, animated: true)
    }
}

extension AppCoordinator: DetailNavigationDelegate {
    func navigateToMain() {
        navigationController.popViewController(animated: true)
    }
}

extension AppCoordinator: PopupCoordinatorDelegate {
    func didFinishPopup() {
        navigationController.presentedViewController?.dismiss(animated: true)
        if let popup = children.last as? PopupCoordinator {
            detachChild(popup)
        }
    }
}
