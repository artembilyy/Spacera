//
//  LaunchCell.swift
//  Spacera
//
//  Created by Artem Bilyi on 15.12.2022.
//

import UIKit

final class LaunchCell: UICollectionViewCell {
    // MARK: identifier
    static let identifier = "LaunchCell"
    // MARK: - UI Elements
    private let container = UIView()
    private let rocketSuccessImage = UIImageView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    
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
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    // MARK: - Configure cell
    private func configureView() {
        //
        contentView.backgroundColor = .black
        contentView.addSubview(container)
        container.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        container.translatesAutoresizingMaskIntoConstraints = false
        //
        titleLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(titleLabel)
        //
        dateLabel.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.561, alpha: 1)
        dateLabel.textAlignment = .right
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(dateLabel)
        //
        rocketSuccessImage.contentMode = .scaleAspectFill
        rocketSuccessImage.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(rocketSuccessImage)
    }
    // MARK: - Cell contraints
    private func setupConstraints() {
        let contrainerConstraints = [
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: -14),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 32)
        ]
        let dateLabelConstraints = [
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 32)
        ]
        let rocketImageConstraints = [
            rocketSuccessImage.widthAnchor.constraint(equalToConstant: 32),
            rocketSuccessImage.heightAnchor.constraint(equalToConstant: 32),
            rocketSuccessImage.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -32),
            rocketSuccessImage.topAnchor.constraint(equalTo: container.topAnchor, constant: -34)
        ]
        NSLayoutConstraint.activate(contrainerConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(dateLabelConstraints)
        NSLayoutConstraint.activate(rocketImageConstraints)
    }
    // MARK: - Data usage
    func configureCell(name: String?, date: String?, success: Bool?) {
        titleLabel.text = name
        dateLabel.text = date
        switch success {
        case true:
            rocketSuccessImage.image = UIImage(named: "rocketTrue")
        case false:
            rocketSuccessImage.image = UIImage(named: "rocketFalse")
        default:
            rocketSuccessImage.image = UIImage(systemName: "questionmark.circle.fill")
        }
    }
}

