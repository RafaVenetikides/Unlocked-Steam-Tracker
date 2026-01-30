//
//  GameCell.swift
//  game-collection
//
//  Created by Rafael Venetikides on 03/10/25.
//

import UIKit

class GameCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    private(set) lazy var trophiesView: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        view.textColor = .systemGray
        
        return view
    }()
    
    private(set) lazy var cellField: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .cellBackground
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        
        return view
    }()
    
    private let spacer = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        setupViews()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(cellField)
        cellField.addSubview(imageView)
        cellField.addSubview(titleLabel)
        cellField.addSubview(spacer)
        cellField.addSubview(trophiesView)
        
        spacer.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        trophiesView.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            cellField.topAnchor.constraint(equalTo: topAnchor),
            cellField.bottomAnchor.constraint(equalTo: bottomAnchor),
            cellField.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellField.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: cellField.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: cellField.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: cellField.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 215.0/460.0),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            spacer.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            spacer.trailingAnchor.constraint(equalTo: trophiesView.leadingAnchor),
            spacer.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            
            trophiesView.trailingAnchor.constraint(equalTo: cellField.trailingAnchor, constant: -8),
            trophiesView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])
    }
    
    func configure(with title: String, image: UIImage?, trophies: (current: Int, total: Int)? = nil) {
        titleLabel.text = title
        imageView.image = image
    }
    
    func configureTrophies(current: Int, total: Int) {
        let trophyConfig = UIImage.SymbolConfiguration(pointSize: 10, weight: .medium)
        let trophyImage = UIImage(systemName: "trophy.fill", withConfiguration: trophyConfig)?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        
        let attachment = NSTextAttachment()
        
        attachment.image = trophyImage
        
        attachment.bounds = CGRect(x: 0, y: -1.5, width: 12, height: 12)
        
        let imageString = NSAttributedString(attachment: attachment)
        let textString = NSAttributedString(string: " \(current)/\(total)", attributes: [.foregroundColor: UIColor.systemGray, .font: UIFont.systemFont(ofSize: 10)])
        
        let combined = NSMutableAttributedString()
        combined.append(imageString)
        combined.append(textString)
        
        trophiesView.attributedText = combined
    }
}
