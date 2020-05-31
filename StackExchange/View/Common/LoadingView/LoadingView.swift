//
//  LoadingView.swift
//  StackExchange
//
//  Created by David Mazzitelli on 31/05/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import UIKit

class LoadingView: UIView {
        
    private let backgroundDarkView = UIView()
    private let activityIndicatorView = UIActivityIndicatorView(style: .large)
    
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        addSubview(backgroundDarkView)
        addSubview(activityIndicatorView)
        
        backgroundDarkView.backgroundColor = UIColor.black
        backgroundDarkView.alpha = 0.4
        
        backgroundDarkView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundDarkView.topAnchor.constraint(equalTo: topAnchor),
            backgroundDarkView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundDarkView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundDarkView.trailingAnchor.constraint(equalTo: trailingAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        activityIndicatorView.startAnimating()
    }
    
    func show(in containerView: UIView?) {
        guard let containerView = containerView else { return }
        
        alpha = 0
        containerView.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: containerView.topAnchor),
            bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { animationComplete in
            if animationComplete {
                self.removeFromSuperview()
            }
        }
    }

}
