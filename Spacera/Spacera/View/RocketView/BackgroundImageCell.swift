//
//  BackgroundImageCell.swift
//  Spacera
//
//  Created by Artem Bilyi on 17.12.2022.
//

import UIKit
import Kingfisher

final class ImageCell: UICollectionViewCell {
    // MARK: identifier
    static let identifier = "ImageCell"
    // MARK: - UI Elements
    private let rocketImage = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented - not using storyboards")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    // MARK: - Configure cell
    private func configureView() {
        contentView.addSubview(rocketImage)
        rocketImage.contentMode = .scaleAspectFill
        rocketImage.translatesAutoresizingMaskIntoConstraints = false
    }
    // MARK: - Cell contraints
    private func setupConstraints() {
        let rocketImageConstraints = [
            rocketImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            rocketImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rocketImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rocketImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(rocketImageConstraints)
    }
    // MARK: - Data usage
    func configureCell(rocket: Rocket) {
        rocketImage.kf.indicatorType = .activity
        if let url = rocket.flickrImages?[1] {
            if let posterPath = URL(string: url) {
                rocketImage.kf.setImage(with: posterPath)
            }
        }
    }
}
