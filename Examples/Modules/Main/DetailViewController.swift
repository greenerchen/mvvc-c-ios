//
//  DetailViewController.swift
//  mvvm-c-ios
//
//  Created by Greener Chen on 2023/3/8.
//

import UIKit

protocol DetailNavigationDelegate: AnyObject {
    func navigateToMain()
}

class DetailViewController: UIViewController {
    weak var navigationDelegate: DetailNavigationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupNavigationTitle()
        setupNavigationBackButton()
        view.backgroundColor = .white
    }
    
    private func setupNavigationTitle() {
        title = "Detail"
    }
    
    private func setupNavigationBackButton() {
        navigationItem.backBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward.circle"),
            style: .plain,
            target: self,
            action: #selector(DetailViewController.didTapBack))
    }
    
    @objc
    private func didTapBack() {
        navigationDelegate?.navigateToMain()
    }
}
