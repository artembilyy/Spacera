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
    // MARK: - Assembly
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
        //
        contentView.backgroundColor = .black
        contentView.addSubview(container)
        container.backgroundColor = Fonts.customLightBlack.color
        container.layer.cornerRadius = 24
        container.translatesAutoresizingMaskIntoConstraints = false
        //
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.textColor = .white
        titleLabel.font = UIFont.setFont(name: LabGrotesque.bold.rawValue, size: 20)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(titleLabel)
        //
        dateLabel.font = UIFont.setFont(name: LabGrotesque.bold.rawValue, size: 16)
        dateLabel.adjustsFontForContentSizeCategory = true
        dateLabel.textColor = Fonts.customMidGray.color
        dateLabel.textAlignment = .left
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
        let rocketImageConstraints = [
            rocketSuccessImage.widthAnchor.constraint(equalToConstant: 32),
            rocketSuccessImage.heightAnchor.constraint(equalToConstant: 32),
            rocketSuccessImage.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -32),
            rocketSuccessImage.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ]
        let titleLabelConstraints = [
            titleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: rocketSuccessImage.leadingAnchor, constant: -16)
        ]
        let dateLabelConstraints = [
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 32)
        ]
        NSLayoutConstraint.activate(contrainerConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(dateLabelConstraints)
        NSLayoutConstraint.activate(rocketImageConstraints)
    }
    // MARK: - Data usage
    func configureCell(launch: Launch) {
        titleLabel.text = launch.name
        dateLabel.text = TextFormatter.convertDateFormat(date: launch.dateLocal ?? "",
                                                         from: DateFormat.yyyyMMddTHHmmssZ,
                                                         to: DateFormat.MMMMdyyyy)
        switch launch.success {
        case true:
            rocketSuccessImage.image = UIImage(named: "rocketTrue")
        case false:
            rocketSuccessImage.image = UIImage(named: "rocketFalse")
        default:
            rocketSuccessImage.image = UIImage(systemName: "questionmark.circle.fill")
            rocketSuccessImage.tintColor = .systemGray
        }
    }
    // MARK: - Empty Data
    func emptyData() {
        titleLabel.text = "No information available"
        rocketSuccessImage.image = UIImage(systemName: "xmark.circle.fill")
        rocketSuccessImage.tintColor = .systemRed
    }
}
