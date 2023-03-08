//
//  MainViewController.swift
//  mvvm-c-ios
//
//  Created by Greener Chen on 2023/3/8.
//

import UIKit

protocol MainNavigationDelegate: AnyObject {
    func navigateToDetail()
    func navigateToPopup()
}

class MainViewController: UIViewController {

    var navigationDelegate: MainNavigationDelegate?
    
    lazy var popupButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "party.popper"), for: .normal)
        button.addTarget(self, action: #selector(MainViewController.didTapPopup), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var detailButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "arrowshape.right"), for: .normal)
        button.addTarget(self, action: #selector(MainViewController.didTapDetail), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(popupButton)
        view.addSubview(detailButton)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: popupButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: popupButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: popupButton, attribute: .trailing, relatedBy: .equal, toItem: detailButton, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: popupButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: popupButton, attribute: .width, relatedBy: .equal, toItem: detailButton, attribute: .width, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: detailButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: detailButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: detailButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        ])
    }
    
    @objc
    private func didTapPopup() {
        navigationDelegate?.navigateToPopup()
    }
    
    @objc
    private func didTapDetail() {
        navigationDelegate?.navigateToDetail()
    }
}

