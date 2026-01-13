//
//  RootTabBarController.swift
//  game-collection
//
//  Created by Rafael Venetikides on 05/10/25.
//

import UIKit

class RootTabBarController: UITabBarController {

    private let auth: AuthManaging
    private let steamService: SteamService
    private let steamId: String

    init(auth: AuthManaging, steamService: SteamService, steamId: String) {
        self.auth = auth
        self.steamService = steamService
        self.steamId = steamId
        super.init(nibName: nil, bundle: nil)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }

    private func setupTabs() {
        let homeVC = HomeViewController(
            auth: auth,
            steamService: steamService,
            steamId: steamId
        )
        let homeNav = UINavigationController(rootViewController: homeVC)
        
        let searchVC = HomeViewController(auth: auth, steamService: steamService, steamId: steamId)
        let searchNav = UINavigationController(rootViewController: searchVC)
        

        let profileVC = ProfileViewController(auth: auth, steamService: steamService, steamId: steamId)
        let profileNav = UINavigationController(rootViewController: profileVC)

        tabs = [
            UITab(title: "Games",
                image: UIImage(systemName: "gamecontroller.fill"),
                identifier: "Games"
            ) { _ in
                homeNav
            },
            UITab(title: "Profile",
                image: UIImage(systemName: "person.fill"),
                identifier: "Profile"
            ) { _ in
                profileNav
            },
            UISearchTab(title: "Search",
                image: UIImage(systemName: "magnifyingglass"),
                identifier: "Search"
            ) { _ in
                searchNav
            },
        ]

        tabBar.tintColor = .white
        tabBar.backgroundColor = .clear
    }
}
