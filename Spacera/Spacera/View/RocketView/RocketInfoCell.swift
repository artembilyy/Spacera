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
    private let leftStyle: NSMutableParagraphStyle = {
        $0.lineHeightMultiple = 1.25
        $0.alignment = .center
        return $0
    }(NSMutableParagraphStyle())
    private let rightStyle: NSMutableParagraphStyle = {
        $0.lineHeightMultiple = 1.19
        $0.alignment = .center
        return $0
    }(NSMutableParagraphStyle())
    private let customString = NSMutableAttributedString()
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
        leftLabel.textColor = Fonts.customMidGray.color
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(leftLabel)
        leftLabel.font = UIFont.setFont(name: LabGrotesque.regular.rawValue, size: 16)
        leftLabel.adjustsFontForContentSizeCategory = true
        rightlabel.textColor = .white
        rightlabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(rightlabel)
        rightlabel.font = UIFont.setFont(name: LabGrotesque.bold.rawValue, size: 16)
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
    private func configurateAttributedString(text: String,
                                             paragraphStyle: NSMutableParagraphStyle) -> NSMutableAttributedString {
        let result = NSMutableAttributedString(string: text,
                                               attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return result
    }
    // MARK: - Data usage
    func configureCell(rocket: Rocket,
                       indexPath: IndexPath) {
        let color = Fonts.customMidGray.color
        let unitTypeStyle = [NSAttributedString.Key.font:
                                UIFont.setFont(name: LabGrotesque.bold.rawValue,
                                               size: 16),
                             NSAttributedString.Key.foregroundColor: color]
        switch indexPath.section {
        case 3:
            switch indexPath.item {
            case 0:
                leftLabel.attributedText = configurateAttributedString(text: RocketUnit.firstFlight.rawValue,
                                                                       paragraphStyle: leftStyle)
                rightlabel.attributedText = configurateAttributedString(text: TextFormatter.convertDateFormat(date: rocket.firstFlight ?? "",
                                                                                                              from: DateFormat.yyyyMMdd,
                                                                                                              to: DateFormat.MMddyyyy),
                                                                        paragraphStyle: rightStyle)
            case 1:
                leftLabel.attributedText = configurateAttributedString(text: RocketUnit.country.rawValue,
                                                                       paragraphStyle: leftStyle)
                rightlabel.attributedText = configurateAttributedString(text: rocket.country ?? "",
                                                                        paragraphStyle: rightStyle)
            case 2:
                leftLabel.attributedText = configurateAttributedString(text: RocketUnit.costPerLaunch.rawValue,
                                                                       paragraphStyle: leftStyle)
                rightlabel.attributedText = configurateAttributedString(text: TextFormatter.roundNumberWithUnit(String(rocket.costPerLaunch ?? 0)),
                                                                        paragraphStyle: rightStyle)
            default:
                return
            }
        case 4:
            switch indexPath.item {
            case 0:
                leftLabel.attributedText = configurateAttributedString(text: RocketUnit.engines.rawValue,
                                                                       paragraphStyle: leftStyle)
                rightlabel.attributedText = configurateAttributedString(text: String(rocket.firstStage?.engines ?? 0),
                                                                        paragraphStyle: rightStyle)
            case 1:
                leftLabel.attributedText = configurateAttributedString(text: RocketUnit.fuelAmountTons.rawValue,
                                                                       paragraphStyle: leftStyle)
                customString.append(configurateAttributedString(text: String(rocket.firstStage?.fuelAmountTons ?? 0),
                                                                  paragraphStyle: leftStyle) )
                customString.append(NSAttributedString(string: " "))
                customString.append(NSMutableAttributedString(string: UnitType.ton.rawValue,
                                                                attributes: unitTypeStyle))
                rightlabel.attributedText = customString
            case 2:
                leftLabel.attributedText = configurateAttributedString(text: RocketUnit.burnTimeSec.rawValue,
                                                                       paragraphStyle: leftStyle)
                if rocket.firstStage?.burnTimeSec != nil {
                    customString.append(configurateAttributedString(text: String(rocket.firstStage?.burnTimeSec ?? 0),
                                                                      paragraphStyle: leftStyle) )
                } else {
                    customString.append(configurateAttributedString(text: "unknown",
                                                                      paragraphStyle: leftStyle))
                }
                customString.append(NSAttributedString(string: " "))
                customString.append(NSAttributedString(string: UnitType.sec.rawValue,
                                                         attributes: unitTypeStyle))
                rightlabel.attributedText = customString
            default:
                return
            }
        case 5:
            switch indexPath.item {
            case 0:
                leftLabel.attributedText = configurateAttributedString(text: RocketUnit.engines.rawValue,
                                                                        paragraphStyle: leftStyle)
                rightlabel.attributedText = configurateAttributedString(text: String(rocket.secondStage?.engines ?? 0),
                                                                        paragraphStyle: rightStyle)
            case 1:
                leftLabel.attributedText = configurateAttributedString(text: RocketUnit.fuelAmountTons.rawValue,
                                                                       paragraphStyle: leftStyle)
                customString.append(configurateAttributedString(text: String(rocket.secondStage?.fuelAmountTons ?? 0),
                                                                  paragraphStyle: leftStyle) )
                customString.append(NSAttributedString(string: " "))
                customString.append(NSMutableAttributedString(string: UnitType.ton.rawValue,
                                                                attributes: unitTypeStyle))
                rightlabel.attributedText = customString
            case 2:
                leftLabel.attributedText =  configurateAttributedString(text: RocketUnit.burnTimeSec.rawValue,
                                                                        paragraphStyle: leftStyle)
                if rocket.secondStage?.burnTimeSec != nil {
                    customString.append(configurateAttributedString(text: String(rocket.secondStage?.burnTimeSec ?? 0),
                                                                      paragraphStyle: leftStyle) )
                } else {
                    customString.append(configurateAttributedString(text: "unknown",
                                                                      paragraphStyle: leftStyle))
                }
                customString.append(NSAttributedString(string: " "))
                customString.append(NSAttributedString(string: UnitType.sec.rawValue,
                                                         attributes: unitTypeStyle))
                rightlabel.attributedText = customString
            default:
                return
            }
        default:
            print("Error while configure RocketInfoCell")
        }
    }
}
