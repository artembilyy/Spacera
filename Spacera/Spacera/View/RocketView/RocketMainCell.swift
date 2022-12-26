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
    private let valueStyle: NSMutableParagraphStyle = {
        $0.lineHeightMultiple = 1.25
        $0.alignment = .center
        return $0
    }(NSMutableParagraphStyle())
    private let unitLabel = UILabel()
    private let unitStlye: NSMutableParagraphStyle = {
        $0.lineHeightMultiple = 1.25
        $0.alignment = .center
        return $0
    }(NSMutableParagraphStyle())
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
    override func prepareForReuse() {
        super.prepareForReuse()
        unitLabel.text = ""
    }
    // MARK: - Configure cell
    private func configureView() {
        contentView.addSubview(container)
        container.layer.backgroundColor = Fonts.customGray.color.cgColor
        container.layer.cornerRadius = 32
        container.translatesAutoresizingMaskIntoConstraints = false
        //
        unitValue.textColor = .white
        unitValue.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(unitValue)
        unitValue.font = UIFont.setFont(name: LabGrotesque.bold.rawValue, size: 16)
        unitValue.adjustsFontForContentSizeCategory = true
        unitLabel.font = UIFont.setFont(name: LabGrotesque.regular.rawValue, size: 16)
        unitLabel.adjustsFontForContentSizeCategory = true
        unitLabel.textColor = Fonts.customMidGray.color
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
    private func customString(text: String, paragraphStyle: NSMutableParagraphStyle) -> NSMutableAttributedString {
        let result = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return result
    }
    // MARK: - Data usage
    func configureCell(rocket: Rocket, indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            if UserDefaults.standard.string(forKey: RocketUnit.height.rawValue) == UnitType.m.rawValue {
                unitValue.attributedText = customString(text: String(rocket.height?.meters ?? 0),
                                                                       paragraphStyle: valueStyle)
                unitLabel.attributedText = customString(text: RocketUnit.height.rawValue.capitalized + ", " + UnitType.m.rawValue,
                                                                       paragraphStyle: unitStlye)
            } else {
                unitValue.attributedText = customString(text: String(rocket.height?.feet ?? 0),
                                                                       paragraphStyle: valueStyle)
                unitLabel.attributedText = customString(text: RocketUnit.height.rawValue.capitalized + ", " + UnitType.ft.rawValue,
                                                                       paragraphStyle: unitStlye)
            }
        case 1:
            if UserDefaults.standard.string(forKey: RocketUnit.diameter.rawValue) == UnitType.m.rawValue {
                unitValue.attributedText = customString(text: String(rocket.diameter?.meters ?? 0),
                                                                       paragraphStyle: valueStyle)
                unitLabel.attributedText = customString(text: RocketUnit.diameter.rawValue.capitalized + ", " + UnitType.m.rawValue,
                                                                      paragraphStyle: unitStlye)
            } else {
                unitValue.attributedText = customString(text: String(rocket.diameter?.feet ?? 0),
                                                                       paragraphStyle: valueStyle)
                unitLabel.attributedText = customString(text: RocketUnit.diameter.rawValue.capitalized + ", " + UnitType.ft.rawValue,
                                                                       paragraphStyle: unitStlye)
            }
        case 2:
            if UserDefaults.standard.string(forKey: RocketUnit.weight.rawValue) == UnitType.kg.rawValue {
                unitValue.attributedText = customString(text: TextFormatter.numberWithCommas(String(rocket.mass?.kg ?? 0)),
                                                                       paragraphStyle: valueStyle)
                unitLabel.attributedText = customString(text: RocketUnit.weight.rawValue.capitalized + ", " + UnitType.kg.rawValue,
                                                                       paragraphStyle: unitStlye)
            } else {
                unitValue.attributedText = customString(text: TextFormatter.numberWithCommas(String(rocket.mass?.lb ?? 0)),
                                                                       paragraphStyle: valueStyle)

                unitLabel.attributedText = customString(text: RocketUnit.weight.rawValue.capitalized + ", " + UnitType.lb.rawValue,
                                                                       paragraphStyle: unitStlye)
            }
        case 3:
            if UserDefaults.standard.string(forKey: RocketUnit.payload.rawValue) == UnitType.kg.rawValue {
                unitValue.attributedText = customString(text: TextFormatter.numberWithCommas(String(rocket.payloadWeights?[0].kg ?? 0)),
                                                                       paragraphStyle: valueStyle)
                unitLabel.attributedText = customString(text: RocketUnit.payload.rawValue.capitalized + ", " + UnitType.kg.rawValue,
                                                                      paragraphStyle: unitStlye)
            } else {
                unitValue.attributedText = customString(text: TextFormatter.numberWithCommas(String(rocket.payloadWeights?[0].lb ?? 0)), paragraphStyle: valueStyle)
                unitLabel.attributedText = customString(text: RocketUnit.payload.rawValue.capitalized + ", " + UnitType.lb.rawValue,
                                                                       paragraphStyle: unitStlye)

            }
        default:
            return
        }
    }
}
