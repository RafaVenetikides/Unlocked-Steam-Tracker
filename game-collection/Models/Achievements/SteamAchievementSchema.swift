//
//  SteamAchievementSchema.swift
//  game-collection
//
//  Created by Rafael Venetikides on 03/10/25.
//

import Foundation

struct SteamSchemaResponse: Decodable {
    let game: SteamGameSchema
}

struct SteamGameSchema : Decodable {
    let availableGameStats: SteamStats?
}

struct SteamStats: Decodable {
    let achievements: [SteamAchievementSchema]?
}

struct SteamAchievementSchema: Decodable {
    let name: String
    let defaultvalue: Int
    let displayName: String
    let hidden: Int
    let description: String?
    let icon: String
    let icongray: String
}
