//
//  UserViewController.swift
//  game-collection
//
//  Created by Rafael Venetikides on 30/09/25.
//

import UIKit
import RealityKit

class UserDetailsViewController: UIViewController {

    let userView = UserView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = userView
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }


}

