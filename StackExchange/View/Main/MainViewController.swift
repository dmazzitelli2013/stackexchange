//
//  MainViewController.swift
//  StackExchange
//
//  Created by David Mazzitelli on 30/05/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var loginButton: UIButton!
    
    var viewModel: MainViewModel? {
        didSet { viewModel?.delegate = self }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resetAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startAnimation()
    }
    
    private func setupViewModel() {
        let coordinator = MainCoordinator(navigationController)
        viewModel = MainViewModel()
        viewModel?.coordinator = coordinator
    }
    
    private func setupButton() {
        loginButton.layer.borderColor = UIColor.darkGray.cgColor
        loginButton.layer.borderWidth = 1
        loginButton.layer.cornerRadius = 10
        loginButton.layer.masksToBounds = true
    }
    
    private func resetAnimation() {
        self.logoImageView.transform = CGAffineTransform.identity
        self.loginButton.alpha = 0
    }
    
    private func startAnimation() {
        UIView.animate(withDuration: 1.0) {
            self.logoImageView.transform = CGAffineTransform(translationX: 0, y: -self.logoImageView.bounds.height - 60)
            self.loginButton.alpha = 1
        }
    }
    
    @IBAction private func loginButtonPressed() {
        viewModel?.login()
    }
    
}

