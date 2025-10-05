//
//  SteamUser.swift
//  game-collection
//
//  Created by Rafael Venetikides on 01/10/25.
//

import Foundation

struct SteamUser: Decodable {
    let stramid: String
    let personaname: String
    let avatarfull: String
}

struct PlayerResponse: Decodable {
    struct Response: Decodable {
        let players: [SteamUser]
    }
    let response: Response
}
