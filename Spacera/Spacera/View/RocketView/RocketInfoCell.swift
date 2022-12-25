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
    private lazy var valueStyle: [NSAttributedString.Key: NSMutableParagraphStyle] = {
        let value = [NSAttributedString.Key: NSMutableParagraphStyle]()
        let valueStyle = [NSAttributedString.Key.paragraphStyle: leftStyle]
        return value
    }()
    private let attributedText = NSMutableAttributedString()
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
    func configureCell(rocket: Rocket,
                       indexPath: IndexPath) {
        guard let boldFont = UIFont(name: LabGrotesque.bold.rawValue, size: 16) else {
            fatalError("Failed to load the LabGrotesque-Bold font.")
        }
        let color = UIColor(red: 0.557, green: 0.557, blue: 0.561, alpha: 1)
        let unitTypeStyle = [NSAttributedString.Key.font: UIFontMetrics.default.scaledFont(for: boldFont),
                             NSAttributedString.Key.foregroundColor: color]
        switch indexPath.section {
        case 3:
            switch indexPath.item {
            case 0:
                leftLabel.attributedText = NSMutableAttributedString(string: RocketUnit.firstFlight.rawValue,
                                                                     attributes: valueStyle)
                rightlabel.attributedText = NSMutableAttributedString(string: TextFormatter.convertDateFormat(date: rocket.firstFlight ?? "",
                                                                                                              from: DateFormat.yyyyMMdd,
                                                                                                              to: DateFormat.MMddyyyy),
                                                                      attributes: [NSAttributedString.Key.paragraphStyle: rightStyle])
            case 1:
                leftLabel.attributedText = NSMutableAttributedString(string: RocketUnit.country.rawValue,
                                                                     attributes: valueStyle)
                rightlabel.attributedText = NSMutableAttributedString(string: rocket.country ?? "",
                                                                      attributes: [NSAttributedString.Key.paragraphStyle: rightStyle])
            case 2:
                leftLabel.attributedText = NSMutableAttributedString(string: RocketUnit.costPerLaunch.rawValue,
                                                                     attributes: valueStyle)
                rightlabel.attributedText = NSMutableAttributedString(string: TextFormatter.roundNumberWithUnit(String(rocket.costPerLaunch ?? 0)),
                                                                      attributes: [NSAttributedString.Key.paragraphStyle: rightStyle])
            default:
                return
            }
        case 4:
            switch indexPath.item {
            case 0:
                leftLabel.attributedText = NSMutableAttributedString(string: RocketUnit.engines.rawValue,
                                                                     attributes: valueStyle)
                rightlabel.attributedText = NSMutableAttributedString(string: String(rocket.firstStage?.engines ?? 0),
                                                                      attributes: [NSAttributedString.Key.paragraphStyle: rightStyle])
            case 1:
                leftLabel.attributedText = NSMutableAttributedString(string: RocketUnit.fuelAmountTons.rawValue,
                                                                     attributes: valueStyle)
                attributedText.append(NSAttributedString(string: String(rocket.firstStage?.fuelAmountTons ?? 0),
                                                         attributes: valueStyle))
                attributedText.append(NSAttributedString(string: " "))
                attributedText.append(NSAttributedString(string: UnitType.ton.rawValue,
                                                         attributes: unitTypeStyle))
                rightlabel.attributedText = attributedText
            case 2:
                leftLabel.attributedText = NSMutableAttributedString(string: RocketUnit.burnTimeSec.rawValue,
                                                                     attributes: valueStyle)
                if rocket.firstStage?.burnTimeSec != nil {
                    attributedText.append(NSAttributedString(string: String((rocket.firstStage?.burnTimeSec)!),
                                                             attributes: valueStyle))
                } else {
                    attributedText.append(NSAttributedString(string: String("unknown"),
                                                             attributes: valueStyle))
                }
                attributedText.append(NSAttributedString(string: " "))
                attributedText.append(NSAttributedString(string: UnitType.sec.rawValue,
                                                         attributes: unitTypeStyle))
                rightlabel.attributedText = attributedText
            default:
                return
            }
        case 5:
            switch indexPath.item {
            case 0:
                leftLabel.attributedText = NSMutableAttributedString(string: RocketUnit.engines.rawValue,
                                                                     attributes: valueStyle)
                rightlabel.attributedText = NSMutableAttributedString(string: String(rocket.secondStage?.engines ?? 0),
                                                                      attributes: [NSAttributedString.Key.paragraphStyle: rightStyle])
            case 1:
                leftLabel.attributedText = NSMutableAttributedString(string: RocketUnit.fuelAmountTons.rawValue,
                                                                     attributes: valueStyle)
                attributedText.append(NSAttributedString(string: String(rocket.secondStage?.fuelAmountTons ?? 0),
                                                         attributes: valueStyle))
                attributedText.append(NSAttributedString(string: " "))
                attributedText.append(NSAttributedString(string: UnitType.ton.rawValue,
                                                         attributes: unitTypeStyle))
                rightlabel.attributedText = attributedText
            case 2:
                leftLabel.attributedText = NSMutableAttributedString(string: RocketUnit.burnTimeSec.rawValue,
                                                                     attributes: valueStyle)
                if rocket.secondStage?.burnTimeSec != nil {
                    attributedText.append(NSAttributedString(string: String((rocket.secondStage?.burnTimeSec)!),
                                                             attributes: valueStyle))
                } else {
                    attributedText.append(NSAttributedString(string: String("unknown"),
                                                             attributes: valueStyle))
                }
                attributedText.append(NSAttributedString(string: " "))
                attributedText.append(NSAttributedString(string: UnitType.sec.rawValue,
                                                         attributes: unitTypeStyle))
                rightlabel.attributedText = attributedText
            default:
                return
            }
        default:
            print("error")
        }
    }
}
