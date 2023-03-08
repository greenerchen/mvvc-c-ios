//
//  PopupViewController.swift
//  mvvm-c-ios
//
//  Created by Greener Chen on 2023/3/8.
//

import UIKit

protocol PopupNavigationDelegate: AnyObject {
    func navigateToMain()
}

class PopupViewController: UIViewController {
    var navigationDelegate: PopupNavigationDelegate?
    
    lazy var popupLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tap the close button to dismiss"
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationButton()
        setupUI()
    }
    
    private func setupNavigationButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark.circle"),
            style: .plain,
            target: self,
            action: #selector(PopupViewController.didTapClose))
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(popupLabel)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: popupLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: popupLabel, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0)
        ])
    }
    
    @objc
    private func didTapClose() {
        navigationDelegate?.navigateToMain()
    }
}
