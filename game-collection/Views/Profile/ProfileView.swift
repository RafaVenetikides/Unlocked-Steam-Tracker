//
//  UserView.swift
//  game-collection
//
//  Created by Rafael Venetikides on 01/10/25.
//

import UIKit

class ProfileView: UIView {

    private(set) lazy var backgroundImage: UIImageView = {
        let image = UIImage(named: "background")
        let view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill

        return view
    }()

    private(set) lazy var profileImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 50
        view.backgroundColor = .secondarySystemBackground

        return view
    }()

    private(set) lazy var usernameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.textColor = .white
        view.font = .systemFont(ofSize: 24, weight: .bold)
        view.numberOfLines = 1

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(backgroundImage)
        addSubview(profileImage)
        addSubview(usernameLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),

            profileImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImage.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor
            ),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            profileImage.heightAnchor.constraint(equalToConstant: 100),

            usernameLabel.topAnchor.constraint(
                equalTo: profileImage.bottomAnchor,
                constant: 16
            ),
            usernameLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            usernameLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
        ])
    }

    func configure(username: String, avatar: UIImage?) {
        usernameLabel.text = username
        if let avatar { profileImage.image = avatar }
    }
}
