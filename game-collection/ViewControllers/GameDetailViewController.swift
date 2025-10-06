//
//  GameDetailViewController.swift
//  game-collection
//
//  Created by Rafael Venetikides on 05/10/25.
//

import UIKit

class GameDetailViewController: UIViewController {
    
    private var gameView = GameDetailView()
    private let steamService = SteamService()
    
    private var appId: Int!
    private var steamId: String!
    
    private var gameName: String?
    private var gameImage: UIImage?
    private var achievements: [SteamAchievementSchema] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func loadView() {
        super.loadView()
        
        self.view = gameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = gameName ?? "Game Details"
        
        gameView.achievementsCollection.delegate = self
        gameView.achievementsCollection.dataSource = self
        gameView.achievementsCollection.register(AchievementsCell.self, forCellWithReuseIdentifier: "AchievementsCell")
        
        configureView()
        loadAchievements()
    }
    
    func setGameData(appId: Int, steamId: String, name: String, imageURL: String) {
        self.appId = appId
        self.steamId = steamId
        self.gameName = name
        
        downloadImage(from: imageURL) { image in
            DispatchQueue.main.async {
                self.gameImage = image
                self.gameView.gameBanner.image = image
            }
        }
    }
    
    private func configureView() {
        gameView.gameBanner.image = gameImage
        gameView.trophyCount.text = "--/--"
        gameView.trophyPercentage.text = "--%"
        gameView.trophyProgress.progress = 0
    }
    
    private func loadAchievements() {
        steamService.fetchGameSchema(appId: appId) { [weak self] allAchievements in
            guard let self, let allAchievements else { return }
            
            DispatchQueue.main.async {
                self.achievements = allAchievements
                self.gameView.achievementsCollection.reloadData()
            }
        }
        
        steamService.fetchPlayerAchievements(steamId: steamId, appId: appId) { [weak self] stats in
            guard let self, let stats = stats else { return }
            
            let earned = stats.achievements?.filter { $0.achieved == 1}.count ?? 0
            let total = stats.achievements?.count ?? 0
            let percentage = total > 0 ? Float(earned) / Float(total) : 0
            
            DispatchQueue.main.async {
                self.gameView.trophyCount.text = "\(earned)/\(total)"
                self.gameView.trophyPercentage.text = String(format: "%.0f%%", percentage * 100)
                self.gameView.trophyProgress.progress = percentage
            }
        }
    }
}

extension GameDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 24, height: 80)
    }
}

extension GameDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return achievements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AchievementsCell", for: indexPath) as! AchievementsCell
        let achievement = achievements[indexPath.item]
        
        cell.titleLabel.text = achievement.displayName
        cell.descriptionLabel.text = achievement.description ?? "No description"
        
        downloadImage(from: achievement.icon) { image in
            DispatchQueue.main.async {
                cell.image.image = image
            }
        }
        
        return cell
    }
}
