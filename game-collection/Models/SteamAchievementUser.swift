//
//  SteamAchievementUser.swift
//  game-collection
//
//  Created by Rafael Venetikides on 03/10/25.
//

import Foundation

struct SteamAchievementsResponse: Decodable {
    let playerstats: SteamGameUserStats?
}

struct SteamGameUserStats: Decodable {
    let steamID: String?
    let gameName: String?
    let achievements: [SteamAchievementUser]?
    let success: Bool?
}

struct SteamAchievementUser: Decodable {
    let apiname: String
    let achieved: Int
    let unlocktime: Int?
    
    enum CodingKeys: String, CodingKey {
        case apiname
        case achieved
        case unlocktime = "unlocktime"
    }
}
