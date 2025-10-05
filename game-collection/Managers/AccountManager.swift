//
//  AccountManager.swift
//  game-collection
//
//  Created by Rafael Venetikides on 01/10/25.
//

import UIKit

protocol AuthManaging {
    var isAuthenticated: Bool { get }
    var steamId: String? { get }
    func setAuthenticated(_ value: Bool, steamId: String?)
}

final class AuthManager: AuthManaging {
    private let repository: AuthRepository
    
    private(set) var isAuthenticated: Bool = false
    private(set) var steamId: String?
    
    init(repository: AuthRepository) {
        self.repository = repository
        
        if let saveId = repository.loadSteamId() {
            self.isAuthenticated = true
            self.steamId = saveId
        }
    }
    
    func setAuthenticated(_ value: Bool, steamId: String?) {
        self.isAuthenticated = value
        self.steamId = steamId
        
        if value, let steamId {
            repository.saveSteamId(steamId)
        } else {
            repository.clearSteamId()
        }
    }
    
    func logout() {
        setAuthenticated(false, steamId: nil)
    }
}
