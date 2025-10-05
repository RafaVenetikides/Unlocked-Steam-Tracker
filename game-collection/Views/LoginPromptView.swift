//
//  LoginPromptView.swift
//  game-collection
//
//  Created by Rafael Venetikides on 01/10/25.
//

import UIKit

class LoginPromptView: UIView {
    
    var loginHandler: (() -> Void)?
    
    private(set) lazy var logoView: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Logo"
        view.font = .systemFont(ofSize: 32, weight: .bold)
        view.textColor =  .white
        
        return view
    }()
    
    private(set) lazy var loginDescriptionView: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "App needs you to sign up with Steam."
        view.font = .systemFont(ofSize: 18, weight: .medium)
        view.textColor =  .white
        
        return view
    }()
    
    private(set) lazy var signInButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Login with Steam", for: .normal)
        view.setTitleColor(.blue, for: .normal)
        view.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .darkTeal
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(logoView)
        addSubview(loginDescriptionView)
        addSubview(signInButton)
        
        setupConstraints()
    }
    
    @objc
    private func handleSignIn() {
        loginHandler?()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            loginDescriptionView.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 20),
            loginDescriptionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            signInButton.topAnchor.constraint(equalTo: loginDescriptionView.bottomAnchor, constant: 20),
            signInButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
}
