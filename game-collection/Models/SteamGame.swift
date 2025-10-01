//
//  SteamGame.swift
//  game-collection
//
//  Created by Rafael Venetikides on 01/10/25.
//

import Foundation

struct SteamGame: Codable {
    let appid: Int
    let name: String
    let playtime_forever: Int
    let img_icon_url: String
    
    let playtime_windows_forever: Int?
    let playtime_mac_forever: Int?
    let playtime_linux_forever: Int?
    let playtime_deck_forever: Int?
    
    let rtime_last_played: Int?
    let content_descriptorids: [Int]?
    let playtime_disconnected: Int?
    
    let playtime_2weeks: Int?
    let has_community_visible_stats: Bool?
    let has_leaderboards: Bool?
}

struct SteamResponse: Codable {
    let game_count: Int
    let games: [SteamGame]
}

struct SteamAPIResult: Codable {
    let response: SteamResponse
}
