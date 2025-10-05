//
//  SteamGameCell.swift
//  game-collection
//
//  Created by Rafael Venetikides on 03/10/25.
//

import Foundation

struct SteamGameBasic: Decodable {
    let appid: Int
    let name: String
    let playtime_forever: Int
    let img_icon_url: String?
    
    var iconURL: URL? {
        guard let hash = img_icon_url else { return nil }
        return URL(string: "https://media.steampowered.com/steamcommunity/public/images/apps/\(appid)/\(hash).jpg")
    }
}
