//
//  CellNumberOne.swift
//  Spacera
//
//  Created by Artem Bilyi on 11.12.2022.
//

import UIKit

final class RocketInfoCell: UICollectionViewCell {
    // MARK: identifier
    static let identifier = "cellIdentifier"
    // MARK: - UI Elements
    private let container = UIView()
    private let unitValue = UILabel()
    private let unitLabel = UILabel()

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
        unitLabel.text = ""
    }
    // MARK: - Configure cell
    private func configureView() {
        contentView.addSubview(container)
        container.layer.backgroundColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1).cgColor
        container.layer.cornerRadius = 32
        container.translatesAutoresizingMaskIntoConstraints = false
        //
        unitValue.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        unitValue.textAlignment = .center
        unitValue.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(unitValue)
//        unitValue.font = UIFont(name: "LabGrotesque-Bold", size: 16)
//        var paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 1.25
//        unitValue.attributedText = NSMutableAttributedString(string: "229.6", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        unitLabel.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.561, alpha: 1)
        unitLabel.textAlignment = .center
        unitLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(unitLabel)
//        unit.font = UIFont(name: "LabGrotesque-Regular", size: 14)
//        var paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 1.19
        //        view.attributedText = NSMutableAttributedString(string: "Высота, ft", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    // MARK: - Cell contraints
    private func setupConstraints() {
        let contrainerConstraints = [
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        let unitValueConstraints = [
            unitValue.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: -16),
            unitValue.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            unitValue.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ]
        let unitConstraints = [
            unitLabel.topAnchor.constraint(equalTo: unitValue.bottomAnchor, constant: 4),
            unitLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            unitLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ]
        NSLayoutConstraint.activate(contrainerConstraints)
        NSLayoutConstraint.activate(unitValueConstraints)
        NSLayoutConstraint.activate(unitConstraints)
    }
    // MARK: - Data usage
    func bindWithMedia(valueForUnit: String, nameForUnitLabel: String) {
        unitValue.text = valueForUnit
        unitLabel.text = nameForUnitLabel
//        UnitTypes.allCases.forEach { unit in
//            self.unitLabel.text = unit.rawValue
//        }
    }
}