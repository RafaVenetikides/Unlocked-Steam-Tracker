//
//  ViewController.swift
//  game-collection
//
//  Created by Rafael Venetikides on 30/09/25.
//

import UIKit
import RealityKit

class ViewController: UIViewController {

    let steamAuth = SteamAuth()
    let userView = UserView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view = userView
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        steamAuth.login { steamId in
            if let steamId = steamId {
                print("Logged in: \(steamId)")
                self.userView.configure(text: steamId)
            } else {
                print("failed")
            }
        }
    }


}

