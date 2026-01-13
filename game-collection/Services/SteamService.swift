//
//  URLSession.swift
//  game-collection
//
//  Created by Rafael Venetikides on 30/09/25.
//

import Foundation
import UIKit

class SteamService {
    
    private var apiKey: String? {
        Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    }
    
    func fetchOwnedGames(steamId: String, completion: @escaping ([SteamGameBasic]?) -> Void) {
        guard let apiKey else {
            print("key not found")
            completion(nil)
            return
        }
        
        let urlString = "https://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=\(apiKey)&steamid=\(steamId)&include_appinfo=true&include_played_free_games=1"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data, error == nil else {
                completion(nil)
                return
            }
            do {
                let decoded = try JSONDecoder().decode(SteamAPIResult.self, from: data)
                completion(decoded.response.games)
            } catch {
                print("Error decodig games: \(String(describing: error))")
                completion(nil)
            }
        }.resume()
    }
    
    func fetchPlayerAchievements(steamId: String, appId: Int, completion: @escaping (SteamGameUserStats?) -> Void) {
        guard let apiKey else {
            completion(nil)
            return
        }
        
        let urlString = "https://api.steampowered.com/ISteamUserStats/GetPlayerAchievements/v0001/?appid=\(appId)&key=\(apiKey)&steamid=\(steamId)"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data, error == nil else {
                completion(nil)
                return
            }
            do {
                let decoded = try JSONDecoder().decode(SteamAchievementsResponse.self, from: data)
                completion(decoded.playerstats)
            } catch {
                if let raw = String(data: data, encoding: .utf8) {
                    if raw.contains("\"success\":false") {
                    } else {
                    }
                }
                completion(nil)
            }
        }.resume()
    }
    
    func fetchGameSchema(appId: Int, completion: @escaping ([SteamAchievementSchema]?) -> Void) {
        guard let apiKey else {
            completion(nil)
            return
        }
        
        let urlString = "https://api.steampowered.com/ISteamUserStats/GetSchemaForGame/v2/?key=\(apiKey)&appid=\(appId)"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data, error == nil else {
                completion(nil)
                return
            }
            do {
                let decoded = try JSONDecoder().decode(SteamSchemaResponse.self, from: data)
                completion(decoded.game.availableGameStats?.achievements)
            } catch {
                print("Error decoding schema \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    func getAppDetails(appId: Int, completion: @escaping (SteamAppDetails?) -> Void) {
        let urlString = "https://store.steampowered.com/api/appdetails?appids=\(appId)"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode([String: SteamAppDetailsResponse].self, from: data)
                    if let first = decoded.values.first, first.success {
                        completion(first.data)
                    } else {
                        completion(nil)
                    }
                } catch {
                    print("Error decoding game: \(error)")
                    if let rawString = String(data: data, encoding: .utf8) {
                        print("Raw string: \(rawString)")
                    }
                    completion(nil)
                }
            } else {
                print("Network error: \(error?.localizedDescription ?? "Unknown")")
                completion(nil)
            }
        }.resume()
    }
    
    func fetchUser(steamId: String, completion: @escaping (SteamUser?) -> Void) {
        guard let apiKey else {
            print("Key not found")
            completion(nil)
            return
        }
        
        let urlString = "https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=\(apiKey)&steamids=\(steamId)"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data {
                do {
                    let decoded = try JSONDecoder().decode(PlayerResponse.self, from: data)
                    completion(decoded.response.players.first)
                } catch {
                    print("Error decoding user: \(error)")
                    completion(nil)
                }
            } else {
                print("Request error: \(String(describing: error))")
                completion(nil)
            }
        }.resume()
    }
}

func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
    guard let url = URL(string: urlString) else {
        print("URL is nil")
        completion(nil)
        return
    }
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
            completion(UIImage(data: data))
        } else {
            completion(nil)
        }
    }.resume()
}
