//
//  LoginPromptViewController.swift
//  game-collection
//
//  Created by Rafael Venetikides on 01/10/25.
//

import UIKit

class LoginPromptViewController: UIViewController {
    
    var onLoginSuccess: ((String) -> Void)?
    private var loginView = LoginPromptView()
    private let steamAuth = SteamAuth()
    private let auth: AuthManaging
    
    init(auth: AuthManaging) {
        self.auth = auth
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.loginHandler = { [weak self] in
            self?.steamAuth.login { steamId in
                if let steamId {
                    self?.onLoginSuccess?(steamId)
                }
            }
        }
    }
   
}
