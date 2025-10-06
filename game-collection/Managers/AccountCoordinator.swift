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
    
    init(auth: AuthManaging, service: SteamService) {
        self.auth = auth
        self.service = service
    }
    
    func start() -> UIViewController {
        if auth.isAuthenticated, let steamId = auth.steamId {
            return RootTabBarController(auth: auth, steamService: service, steamId: steamId)
        } else {
            let loginVC = LoginPromptViewController(auth: auth)
            loginVC.onLoginSuccess = { [weak self] steamId in
                guard let self else { return }
                self.auth.setAuthenticated(true, steamId: steamId)
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.startAppFlow()
            }
            return UINavigationController(rootViewController: loginVC)
        }
    }
}
