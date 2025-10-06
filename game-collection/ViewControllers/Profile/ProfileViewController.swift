//
//  ProfileViewController.swift
//  game-collection
//
//  Created by Rafael Venetikides on 05/10/25.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let auth: AuthManaging
    private let profileView = ProfileView()
    
    override func loadView() {
        super.loadView()
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    init(auth: AuthManaging) {
        self.auth = auth
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
