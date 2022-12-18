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
    private let rocketName = UILabel()
    private let settingsButton = UIImageView()
    weak var viewController: UIViewController?
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
        contentView.addSubview(container)
        container.backgroundColor = .black
        container.translatesAutoresizingMaskIntoConstraints = false
        //
        rocketName.backgroundColor = .clear
        guard let customFont = UIFont(name: LabGrotesque.medium.rawValue, size: 24) else {
            fatalError("Failed to load the LabGrotesque-Medium font.")
        }
        rocketName.font = UIFontMetrics.default.scaledFont(for: customFont)
        rocketName.adjustsFontForContentSizeCategory = true
        //        let paragraphStyle = NSMutableParagraphStyle()
        //        paragraphStyle.lineHeightMultiple = 100
        //        rocketName.attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        rocketName.textAlignment = .left
        rocketName.textColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        rocketName.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(rocketName)
        settingsButton.image = UIImage(systemName: "gearshape")
        settingsButton.tintColor = UIColor(red: 0.792, green: 0.792, blue: 0.792, alpha: 1)
        settingsButton.contentMode = .scaleAspectFill
        settingsButton.isUserInteractionEnabled = true
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(settingsPressed))
        settingsButton.addGestureRecognizer(tapAction)
        container.addSubview(settingsButton)
    }
    @objc
    private func settingsPressed() {
        let settingsViewController = SettingsViewController()
        let navController = UINavigationController(rootViewController: settingsViewController)
        viewController?.present(navController, animated: true)
    }
    // MARK: - Cell contraints
    private func setupConstraints() {
        let contrainerConstraints = [
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        let rocketLabelConstraints = [
            rocketName.topAnchor.constraint(equalTo: contentView.topAnchor),
            rocketName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            rocketName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            rocketName.widthAnchor.constraint(equalToConstant: 170),
        ]
        let buttonGearConstraints = [
            settingsButton.heightAnchor.constraint(equalToConstant: 32),
            settingsButton.widthAnchor.constraint(equalToConstant: 32),
            settingsButton.centerYAnchor.constraint(equalTo: rocketName.centerYAnchor),
            settingsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        ]
        NSLayoutConstraint.activate(contrainerConstraints)
        NSLayoutConstraint.activate(rocketLabelConstraints)
        NSLayoutConstraint.activate(buttonGearConstraints)
    }
    // MARK: - Data usage
    func configureCell(name: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.19
        rocketName.attributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
}
