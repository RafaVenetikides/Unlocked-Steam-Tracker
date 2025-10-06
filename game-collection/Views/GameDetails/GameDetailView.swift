//
//  GameDetailView.swift
//  game-collection
//
//  Created by Rafael Venetikides on 05/10/25.
//

import UIKit

class GameDetailView: UIView {
    
    private(set) lazy var backgroundImage: UIImageView = {
        let image = UIImage(named: "background")
        let view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    private(set) lazy var gameBanner: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    private(set) lazy var achievementsTitle: UILabel = {
        let view = UILabel()
        view.text = "Achievements"
        view.textColor = .white
        view.font = .systemFont(ofSize: 16, weight: .semibold)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private(set) lazy var trophyCount: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16, weight: .semibold)
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private(set) lazy var trophyPercentage: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16, weight: .semibold)
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private(set) lazy var trophyProgress: UIProgressView = {
        let view = UIProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.progressTintColor = .progress
        view.trackTintColor = .track
        
        return view
    }()
    
    private(set) lazy var achievementsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(backgroundImage)
        addSubview(gameBanner)
        addSubview(achievementsTitle)
        addSubview(trophyCount)
        addSubview(trophyPercentage)
        addSubview(trophyProgress)
        addSubview(achievementsCollection)
    }
    
    func setupConstaints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            gameBanner.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            gameBanner.leadingAnchor.constraint(equalTo: leadingAnchor),
            gameBanner.trailingAnchor.constraint(equalTo: trailingAnchor),
            gameBanner.heightAnchor.constraint(equalToConstant: 184),
            
            achievementsTitle.topAnchor.constraint(equalTo: gameBanner.bottomAnchor, constant: 14),
            achievementsTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            
            trophyCount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            trophyCount.topAnchor.constraint(equalTo: achievementsTitle.bottomAnchor, constant: 12),
            
            trophyPercentage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            trophyPercentage.topAnchor.constraint(equalTo: trophyCount.topAnchor),
            
            trophyProgress.topAnchor.constraint(equalTo: trophyCount.bottomAnchor, constant: 8),
            trophyProgress.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            trophyProgress.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            achievementsCollection.topAnchor.constraint(equalTo: trophyProgress.bottomAnchor, constant: 30),
            achievementsCollection.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            achievementsCollection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            achievementsCollection.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
    }
    
}
