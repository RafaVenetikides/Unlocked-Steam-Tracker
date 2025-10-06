//
//  SteamAppDetails.swift
//  game-collection
//
//  Created by Rafael Venetikides on 04/10/25.
//

struct SteamAppDetailsResponse: Decodable {
    let success: Bool
    let data: SteamAppDetails
}

struct SteamAppDetails: Decodable {
    let steam_appid: Int
    let name: String
    let header_image: String
}
