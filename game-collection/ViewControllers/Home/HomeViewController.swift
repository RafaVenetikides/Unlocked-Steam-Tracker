//
//  HomeViewController.swift
//  game-collection
//
//  Created by Rafael Venetikides on 03/10/25.
//

import UIKit

class HomeViewController: UIViewController {

    private let auth: AuthManaging
    private let steamService: SteamService
    private let steamId: String

    private var homeView = HomeView()

    private var games: [SteamGameBasic] = []
    private var appDetailsCache: [Int: SteamAppDetails] = [:]
    private var achievementsCache: [Int: (earned: Int, total: Int)] = [:]
    
    private var filteredGames: [SteamGameBasic] = []
    private var searchController = UISearchController(searchResultsController: nil)

    init(auth: AuthManaging, steamService: SteamService, steamId: String) {
        self.auth = auth
        self.steamService = steamService
        self.steamId = steamId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = homeView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Your Games"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Games"

        homeView.collectionView.delegate = self
        homeView.collectionView.dataSource = self

        loadGames()
    }

    private func loadGames() {
        steamService.fetchOwnedGames(steamId: steamId) { [weak self] games in
            guard let self, let games else { return }

            DispatchQueue.main.async {
                self.games = games
                self.filteredGames = games
                self.homeView.collectionView.reloadData()
            }

            for game in games {
                self.steamService.getAppDetails(appId: game.appid) { details in
                    guard let details else { return }
                    DispatchQueue.main.async {
                        self.appDetailsCache[game.appid] = details
                        if let index = self.games.firstIndex(where: {
                            $0.appid == game.appid
                        }) {
                            let indexPath = IndexPath(item: index, section: 0)
                            self.homeView.collectionView.reloadItems(at: [
                                indexPath
                            ])
                        }
                    }
                }
                self.loadAchievements(for: game)
            }
        }
    }

    private func loadAchievements(for game: SteamGameBasic) {
        steamService.fetchGameSchema(appId: game.appid) {
            [weak self] allAchievements in
            guard let self else { return }
            let total = allAchievements?.count ?? 0

            self.steamService.fetchPlayerAchievements(
                steamId: self.steamId,
                appId: game.appid
            ) { userStats in
                let earned =
                    userStats?.achievements?.filter { $0.achieved == 1 }.count
                    ?? 0

                DispatchQueue.main.async {
                    if total == 0 && earned == 0 {
                        return
                    }
                    self.achievementsCache[game.appid] = (earned, total)
                    if let index = self.games.firstIndex(where: {
                        $0.appid == game.appid
                    }) {
                        let indexPath = IndexPath(item: index, section: 0)
                        self.homeView.collectionView.reloadItems(at: [indexPath]
                        )
                    }
                }
            }
        }
    }

    @objc
    private func sort() {

    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let game = filteredGames[indexPath.item]
        
        let detailVC = GameDetailViewController()

        if let details = appDetailsCache[game.appid] {
            detailVC.setGameData(appId: game.appid, steamId: steamId, name: game.name, imageURL: details.header_image)
        } else {
            detailVC.setGameData(appId: game.appid, steamId: steamId, name: game.name, imageURL: "")
        }
        
        navigationController?.pushViewController(detailVC, animated: true)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.bounds.width / 2 - 16
        return CGSize(width: width, height: 120)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return filteredGames.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: "GameCell",
                for: indexPath
            ) as! GameCell

        let game = filteredGames[indexPath.item]
        let title = game.name

        if let details = appDetailsCache[game.appid] {
            downloadImage(from: details.header_image) { image in
                DispatchQueue.main.async {
                    cell.configure(with: title, image: image)
                }
            }
        } else {
            cell.configure(
                with: title,
                image: UIImage(systemName: "gamecontroller.fill")
            )
        }

        if let trophies = achievementsCache[game.appid] {
            DispatchQueue.main.async {
                cell.configureTrophies(
                    current: trophies.earned,
                    total: trophies.total
                )
            }
        } else {
            cell.configureTrophies(current: 0, total: 0)
        }

        return cell
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.lowercased(), !text.isEmpty else {
            filteredGames = games
            homeView.collectionView.reloadData()
            return
        }
        
        filteredGames = games.filter { $0.name.lowercased().contains(text) }
        homeView.collectionView.reloadData()
    }
}
