//
//  AccountCoordinator.swift
//  game-collection
//
//  Created by Rafael Venetikides on 01/10/25.
//

import UIKit

final class AccountCoordinator {
    private weak var nav: UINavigationController?
    private let auth: AuthManaging
    private let service: SteamService
    
    init(nav: UINavigationController, auth: AuthManaging, service: SteamService) {
        self.nav = nav
        self.auth = auth
        self.service = service
    }
    
    func start() {
        if auth.isAuthenticated, let steamId = auth.steamId {
            showHome(steamId: steamId)
        } else {
            showLogin()
        }
    }
    
    private func showLogin() {
        let loginVC = LoginPromptViewController(auth: auth)
        loginVC.onLoginSuccess = { [weak self] steamId in
            guard let self else { return }
            self.auth.setAuthenticated(true, steamId: steamId)
            self.showHome(steamId: steamId)
        }
        nav?.setViewControllers([loginVC], animated: false)
    }
    
    private func showHome(steamId: String) {
        let homeVC = HomeViewController(auth: auth, steamService: service, steamId: steamId)
        nav?.setViewControllers([homeVC], animated: true)
    }
}
