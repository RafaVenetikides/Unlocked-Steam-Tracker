//
//  LoginPromptView.swift
//  game-collection
//
//  Created by Rafael Venetikides on 01/10/25.
//

import UIKit

class LoginPromptView: UIView {
    
    var loginHandler: (() -> Void)?
    
    private(set) lazy var logoView: UIImageView = {
        let image = UIImage(named: "logo")
        let view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    private(set) lazy var loginDescriptionView: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Connect your Steam account to view your achievements."
        view.font = .systemFont(ofSize: 18, weight: .medium)
        view.textColor = .white
        view.numberOfLines = 0
        view.textAlignment = .center

        return view
    }()
    
    private(set) lazy var signInButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage(named: "steamLogin"), for: .normal)
        view.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        
        return view
    }()

    private(set) lazy var disclaimerLabel: UILabel = {
        let view = UILabel()
        view.text = "This app is not affiliated with Valve."
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 15, weight: .regular)
        view.textColor =  .white
        view.textAlignment = .center

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
        addSubview(disclaimerLabel)

        setupConstraints()
    }
    
    @objc
    private func handleSignIn() {
        loginHandler?()
    }
    
    private func setupConstraints() {
        
        if let image = signInButton.image(for: .normal) {
            let ratio = image.size.height/image.size.width
            signInButton.heightAnchor.constraint(equalTo: signInButton.widthAnchor, multiplier: ratio).isActive = true
        }
        
        NSLayoutConstraint.activate([
            logoView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -60),
            logoView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            logoView.heightAnchor.constraint(equalTo: logoView.widthAnchor),
            
            loginDescriptionView.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 20),
            loginDescriptionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginDescriptionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            loginDescriptionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            signInButton.topAnchor.constraint(equalTo: loginDescriptionView.bottomAnchor, constant: 20),
            signInButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            signInButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),

            disclaimerLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            disclaimerLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            disclaimerLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
}
