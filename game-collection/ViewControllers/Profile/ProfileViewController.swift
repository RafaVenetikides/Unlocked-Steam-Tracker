//
//  ProfileViewController.swift
//  game-collection
//
//  Created by Rafael Venetikides on 05/10/25.
//

import UIKit

class ProfileViewController: UIViewController {

    private let auth: AuthManaging
    private let steamService: SteamService
    private let steamId: String

    private let profileView = ProfileView()

    init(auth: AuthManaging, steamService: SteamService, steamId: String) {
        self.auth = auth
        self.steamService = steamService
        self.steamId = steamId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "rectangle.portrait.and.arrow.right"),
            style: .plain,
            target: self,
            action: #selector(didTapLogout)
        )

        loadProfile()
    }

    @objc
    private func didTapLogout() {
        let alert = UIAlertController(
            title: "Sair?",
            message: "Você quer deslogar da sua conta Steam?",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alert.addAction(
            UIAlertAction(title: "Sair", style: .destructive) { [weak self] _ in
                guard let self else { return }
                
                self.auth.setAuthenticated(false, steamId: self.steamId)
                if let sceneDelegate = UIApplication.shared.connectedScenes
                    .compactMap({ $0.delegate as? SceneDelegate }).first
                {
                    sceneDelegate.startAppFlow()
                }
            }
        )
        present(alert, animated: true)
    }

    private func loadProfile() {
        steamService.fetchUser(steamId: steamId) { [weak self] user in
            guard let self, let user else { return }

            DispatchQueue.main.async {
                self.profileView.configure(
                    username: user.personaname,
                    avatar: nil
                )
            }

            downloadImage(from: user.avatarfull) { image in
                DispatchQueue.main.async {
                    self.profileView.configure(
                        username: user.personaname,
                        avatar: image
                    )
                }
            }
        }
    }
}
