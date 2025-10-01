//
//  URLSession.swift
//  game-collection
//
//  Created by Rafael Venetikides on 30/09/25.
//

import Foundation

import Foundation



func fetchSteamGames() {
    guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
        print("API key not found")
        return
    }
    let steamId = "76561198413143268"
    let urlString = "https://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=\(apiKey)&steamid=\(steamId)&include_appinfo=true"
    
    guard let url = URL(string: urlString) else { return }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
            do {
                let decoded = try JSONDecoder().decode(SteamAPIResult.self, from: data)
                print("games found: \(decoded.response.game_count)")
                for game in decoded.response.games.sorted(by: {$0.playtime_forever >= $1.playtime_forever}) {
                    print("- \(game.name) (Game time: \(game.playtime_forever))")
                }
            } catch {
                print("Error decoding")
                if let raw = String(data: data, encoding: .utf8) {
                    print(apiKey)
                    print("JSON: \(raw)")
                }
            }
        } else if let error = error {
            print("Request error: \(error)")
        }
    }.resume()
}
