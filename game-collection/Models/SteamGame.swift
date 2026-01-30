//
//  SteamGame.swift
//  game-collection
//
//  Created by Rafael Venetikides on 03/10/25.
//

import Foundation

struct SteamAPIResult: Decodable {
    let response: SteamAPIResponse
}

struct SteamAPIResponse: Decodable {
    let game_count: Int?
    let games: [SteamGameBasic]?
}

struct SteamGame {
    let basic: SteamGameBasic
    let userAchievements: [SteamAchievementUser]?
    let schemaAchievements: [SteamAchievementSchema]?
    
    var unlockedCount: Int {
        userAchievements?.filter { $0.achieved == 1 }.count ?? 0
    }
    
    var totalCount: Int {
        schemaAchievements?.count ?? userAchievements?.count ?? 0
    }
}
