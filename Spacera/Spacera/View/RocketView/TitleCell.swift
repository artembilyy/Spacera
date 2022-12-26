//
//  TitleCell.swift
//  Spacera
//
//  Created by Artem Bilyi on 16.12.2022.
//

import UIKit

final class TitleCell: UICollectionViewCell {
    // MARK: identifier
    static let identifier = "titleCellIdentifier"
    // MARK: - UI Elements
    private let container = UIView()
    private let title = UILabel()
    private let settingsButton = UIImageView()
    weak var viewController: UIViewController?
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
        contentView.addSubview(container)
        container.backgroundColor = .black
        container.translatesAutoresizingMaskIntoConstraints = false
        //
        title.backgroundColor = .clear
        title.font = UIFont.setFont(name: LabGrotesque.medium.rawValue, size: 32)
        title.adjustsFontForContentSizeCategory = true
        title.textAlignment = .left
        title.textColor = Fonts.customWhire.color
        title.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(title)
        settingsButton.image = UIImage(systemName: "gearshape")
        settingsButton.tintColor = Fonts.customLightGray.color
        settingsButton.contentMode = .scaleAspectFill
        settingsButton.isUserInteractionEnabled = true
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(settingsPressed))
        settingsButton.addGestureRecognizer(tapAction)
        container.addSubview(settingsButton)
    }
    // MARK: - Present action button
    @objc
    private func settingsPressed() {
        let settingsViewController = SettingsViewController()
        let navController = UINavigationController(rootViewController: settingsViewController)
        viewController?.present(navController, animated: true)
    }
    // MARK: - Cell constraints
    private func setupConstraints() {
        let contrainerConstraints = [
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        let rocketLabelConstraints = [
            title.topAnchor.constraint(equalTo: contentView.topAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            title.widthAnchor.constraint(equalToConstant: 220)
        ]
        let buttonGearConstraints = [
            settingsButton.heightAnchor.constraint(equalToConstant: 32),
            settingsButton.widthAnchor.constraint(equalTo: settingsButton.heightAnchor, multiplier: 1),
            settingsButton.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            settingsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        ]
        NSLayoutConstraint.activate(contrainerConstraints)
        NSLayoutConstraint.activate(rocketLabelConstraints)
        NSLayoutConstraint.activate(buttonGearConstraints)
    }
    // MARK: - Data usage
    func configureCell(rocket: Rocket) {
        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = 1.19
        if let name = rocket.name {
            title.attributedText = NSMutableAttributedString(string: name,
                                                             attributes: [NSAttributedString.Key.paragraphStyle: style])
        }
    }
}
