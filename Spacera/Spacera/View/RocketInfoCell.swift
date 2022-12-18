//
//  RocketInfoCell.swift
//  Spacera
//
//  Created by Artem Bilyi on 14.12.2022.
//

import UIKit

final class RocketInfoCell: UICollectionViewCell {
    // MARK: identifier
    static let identifier = "rocketInfoCell"
    // MARK: - UI Elements
    private let container = UIView()
    private let leftLabel = UILabel()
    private let rightlabel = UILabel()
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
        leftLabel.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.561, alpha: 1)
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(leftLabel)
        guard let regulardFont = UIFont(name: LabGrotesque.regular.rawValue, size: 16) else {
            fatalError("Failed to load the LabGrotesque-Bold font.")
        }
        leftLabel.font = UIFontMetrics.default.scaledFont(for: regulardFont)
        leftLabel.adjustsFontForContentSizeCategory = true
        rightlabel.textColor = .white
        rightlabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(rightlabel)
        guard let boldFont = UIFont(name: LabGrotesque.bold.rawValue, size: 16) else {
            fatalError("Failed to load the LabGrotesque-Bold font.")
        }
        rightlabel.font = UIFontMetrics.default.scaledFont(for: boldFont)
        rightlabel.adjustsFontForContentSizeCategory = true
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
            leftLabel.topAnchor.constraint(equalTo: container.topAnchor),
            leftLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            leftLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            leftLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 32)
        ]
        let unitConstraints = [
            rightlabel.centerYAnchor.constraint(equalTo: leftLabel.centerYAnchor),
            rightlabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -32)
        ]
        NSLayoutConstraint.activate(contrainerConstraints)
        NSLayoutConstraint.activate(unitValueConstraints)
        NSLayoutConstraint.activate(unitConstraints)
    }
    // MARK: - Data usage
    func configureCell(dict: [String: [String: [String]]],
                       mainKey: String,
                       indexPath: IndexPath) {
        let leftStyle = NSMutableParagraphStyle()
        leftStyle.lineHeightMultiple = 1.25
        leftStyle.alignment = .center
        let rightStyle = NSMutableParagraphStyle()
        rightStyle.lineHeightMultiple = 1.19
        rightStyle.alignment = .center
        switch indexPath.section {
        case 3:
            switch indexPath.item {
            case 0:
                leftLabel.attributedText = NSMutableAttributedString(string: RocketViewText.firstFlight.rawValue, attributes: [NSAttributedString.Key.paragraphStyle: leftStyle])
                rightlabel.attributedText = NSMutableAttributedString(string: dict[mainKey]?[Rockets.firstFlight.rawValue]?.first ?? "", attributes: [NSAttributedString.Key.paragraphStyle: rightStyle])
            case 1:
                leftLabel.attributedText = NSMutableAttributedString(string: RocketViewText.country.rawValue, attributes: [NSAttributedString.Key.paragraphStyle: leftStyle])
                rightlabel.attributedText = NSMutableAttributedString(string: dict[mainKey]?[Rockets.country.rawValue]?.first ?? "", attributes: [NSAttributedString.Key.paragraphStyle: rightStyle])
            case 2:
                leftLabel.attributedText = NSMutableAttributedString(string: RocketViewText.costPerLaunch.rawValue, attributes: [NSAttributedString.Key.paragraphStyle: leftStyle])
                rightlabel.attributedText = NSMutableAttributedString(string: dict[mainKey]?[Rockets.costPerLaunch.rawValue]?.first ?? "", attributes: [NSAttributedString.Key.paragraphStyle: rightStyle])
            default:
                return
            }
        case 4:
            switch indexPath.item {
            case 0:
                leftLabel.attributedText = NSMutableAttributedString(string: RocketViewText.engines.rawValue, attributes: [NSAttributedString.Key.paragraphStyle: leftStyle])
                rightlabel.attributedText = NSMutableAttributedString(string: dict[mainKey]?[Rockets.firstStageEngines.rawValue]?.first ?? "", attributes: [NSAttributedString.Key.paragraphStyle: rightStyle])
            case 1:
                leftLabel.attributedText = NSMutableAttributedString(string: RocketViewText.fuelAmountTons.rawValue, attributes: [NSAttributedString.Key.paragraphStyle: leftStyle])
                rightlabel.attributedText = NSMutableAttributedString(string: dict[mainKey]?[Rockets.firstStageFuelAmountTons.rawValue]?.first ?? "", attributes: [NSAttributedString.Key.paragraphStyle: rightStyle])
            case 2:
                leftLabel.attributedText = NSMutableAttributedString(string: RocketViewText.burnTimeSec.rawValue, attributes: [NSAttributedString.Key.paragraphStyle: leftStyle])
                rightlabel.attributedText = NSMutableAttributedString(string: dict[mainKey]?[Rockets.firstStageBurnTimeSEC.rawValue]?.first ?? "", attributes: [NSAttributedString.Key.paragraphStyle: rightStyle])
            default:
                return
            }
        case 5:
            switch indexPath.item {
            case 0:
                leftLabel.attributedText = NSMutableAttributedString(string: RocketViewText.engines.rawValue, attributes: [NSAttributedString.Key.paragraphStyle: leftStyle])
                rightlabel.attributedText = NSMutableAttributedString(string: dict[mainKey]?[Rockets.secondStageEngines.rawValue]?.first ?? "", attributes: [NSAttributedString.Key.paragraphStyle: rightStyle])
            case 1:
                leftLabel.attributedText = NSMutableAttributedString(string: RocketViewText.fuelAmountTons.rawValue, attributes: [NSAttributedString.Key.paragraphStyle: leftStyle])
                rightlabel.attributedText = NSMutableAttributedString(string: dict[mainKey]?[Rockets.secondStageFuelAmountTons.rawValue]?.first ?? "", attributes: [NSAttributedString.Key.paragraphStyle: rightStyle])
            case 2:
                let attributedText = NSMutableAttributedString()
                guard let boldFont = UIFont(name: LabGrotesque.bold.rawValue, size: 16) else {
                    fatalError("Failed to load the LabGrotesque-Bold font.")
                }
                let valueStyle = [NSAttributedString.Key.paragraphStyle: leftStyle]
                let color = UIColor(red: 0.557, green: 0.557, blue: 0.561, alpha: 1)
                let unitTypeStyle = [NSAttributedString.Key.font: UIFontMetrics.default.scaledFont(for: boldFont),
                                     NSAttributedString.Key.foregroundColor: color]
                attributedText.append(NSAttributedString(string: "\( dict[mainKey]?[Rockets.secondStageBurnTimeSEC.rawValue]?.first ?? "")", attributes: valueStyle))
                attributedText.append(NSAttributedString(string: " "))
                attributedText.append(NSAttributedString(string: UnitType.sec.rawValue, attributes: unitTypeStyle))
                leftLabel.attributedText = NSMutableAttributedString(string: RocketViewText.burnTimeSec.rawValue, attributes: [NSAttributedString.Key.paragraphStyle: leftStyle])
                rightlabel.attributedText = attributedText
            default:
                return
            }
        default:
            print("error")
        }
    }
}
