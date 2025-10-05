//
//  UserDefaultsAuthRepository.swift
//  game-collection
//
//  Created by Rafael Venetikides on 03/10/25.
//

import Foundation

protocol AuthRepository {
    func loadSteamId() -> String?
    func saveSteamId(_ steamId: String)
    func clearSteamId()
}

final class UserDefaultsAuthRepository: AuthRepository {
    private enum Keys {
        static let steamId = "steamId"
    }
    
    func loadSteamId() -> String? {
        UserDefaults.standard.string(forKey: Keys.steamId)
    }
    
    func saveSteamId(_ steamId: String) {
        UserDefaults.standard.set(steamId, forKey: Keys.steamId)
    }
    
    func clearSteamId() {
        UserDefaults.standard.removeObject(forKey: Keys.steamId)
    }
}
