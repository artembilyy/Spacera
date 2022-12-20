//
//  CellNumberOne.swift
//  Spacera
//
//  Created by Artem Bilyi on 11.12.2022.
//

import UIKit

final class RocketMainCell: UICollectionViewCell {
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
        unitValue.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(unitValue)
        guard let boldFont = UIFont(name: LabGrotesque.bold.rawValue, size: 16) else {
            fatalError("Failed to load the LabGrotesque-Bold font.")
        }
        unitValue.font = UIFontMetrics.default.scaledFont(for: boldFont)
        unitValue.adjustsFontForContentSizeCategory = true
        guard let regularFont = UIFont(name: LabGrotesque.regular.rawValue, size: 16) else {
            fatalError("Failed to load the LabGrotesque-Regular font.")
        }
        unitLabel.font = UIFontMetrics.default.scaledFont(for: regularFont)
        unitLabel.adjustsFontForContentSizeCategory = true
        unitLabel.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.561, alpha: 1)
        unitLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(unitLabel)
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
            unitValue.topAnchor.constraint(equalTo: container.topAnchor, constant: 24),
            unitValue.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            unitValue.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8)
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
    func configureCell(dictionary: [String: [String: [String]]],
                       mainKey: String,
                       switchUnit: Int,
                       indexPath: IndexPath) {
        let valueStyle = NSMutableParagraphStyle()
        valueStyle.lineHeightMultiple = 1.25
        valueStyle.alignment = .center
        let unitStlye = NSMutableParagraphStyle()
        unitStlye.lineHeightMultiple = 1.19
        unitStlye.alignment = .center
        if indexPath.section == 2 {
            if indexPath.item == 0 {
                unitValue.attributedText = NSMutableAttributedString(string: dictionary[mainKey]?[Rockets.height.rawValue]?[switchUnit] ?? "",
                                                                     attributes: [NSAttributedString.Key.paragraphStyle: valueStyle])
                unitLabel.attributedText = NSMutableAttributedString(string: Rockets.height.rawValue.capitalized,
                                                                     attributes: [NSAttributedString.Key.paragraphStyle: unitStlye])
            } else if indexPath.item == 1 {
                unitValue.attributedText = NSMutableAttributedString(string: dictionary[mainKey]?[Rockets.diameter.rawValue]?[switchUnit] ?? "",
                                                                     attributes: [NSAttributedString.Key.paragraphStyle: valueStyle])
                unitLabel.attributedText = NSMutableAttributedString(string: Rockets.diameter.rawValue.capitalized,
                                                                     attributes: [NSAttributedString.Key.paragraphStyle: unitStlye])
            } else if indexPath.item == 2 {
                unitValue.attributedText = NSMutableAttributedString(string: TextFormatter.numberWithCommas(dictionary[mainKey]?[Rockets.weight.rawValue]?[switchUnit] ?? ""),
                                                                     attributes: [NSAttributedString.Key.paragraphStyle: valueStyle])
                unitLabel.attributedText = NSMutableAttributedString(string: Rockets.weight.rawValue.capitalized,
                                                                     attributes: [NSAttributedString.Key.paragraphStyle: unitStlye])
            } else if indexPath.item == 3 {
                unitValue.attributedText = NSMutableAttributedString(string: TextFormatter.numberWithCommas(dictionary[mainKey]?[Rockets.payload.rawValue]?[switchUnit] ?? ""),
                                                                     attributes: [NSAttributedString.Key.paragraphStyle: valueStyle])
                unitLabel.attributedText = NSMutableAttributedString(string: Rockets.payload.rawValue.capitalized,
                                                                     attributes: [NSAttributedString.Key.paragraphStyle: unitStlye])
            }
        }
    }
}
