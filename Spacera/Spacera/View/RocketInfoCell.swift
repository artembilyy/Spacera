//
//  RocketInfoCell.swift
//  Spacera
//
//  Created by Artem Bilyi on 14.12.2022.
//

import UIKit

enum CellText: String {
    case firstFlight    = "First flight"
    case country        = "Country"
    case costPerLaunch  = "Cost per launch"
    case engines        = "Engines count"
    case fuelAmountTons = "Fuel amount"
    case burnTimeSec    = "Burn time"
}

enum SectionHeaderText: String {
    case firstStage     = "FIRST STAGE"
    case secondStage    = "SECOND STAGE"
}

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
        leftLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        leftLabel.textAlignment = .left
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(leftLabel)
        
        //        unitValue.font = UIFont(name: "LabGrotesque-Bold", size: 16)
        //        var paragraphStyle = NSMutableParagraphStyle()
        //        paragraphStyle.lineHeightMultiple = 1.25
        //        unitValue.attributedText = NSMutableAttributedString(string: "229.6", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        rightlabel.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.561, alpha: 1)
        rightlabel.textAlignment = .right
        rightlabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(rightlabel)
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
    func configureCell(dict: [String: [String: [String]]], mainKey: String, indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            switch indexPath.item {
            case 0:
                leftLabel.text = CellText.firstFlight.rawValue
                rightlabel.text = dict[mainKey]?[Rockets.firstFlight.rawValue]?.first
            case 1:
                leftLabel.text = CellText.country.rawValue
                rightlabel.text = dict[mainKey]?[Rockets.country.rawValue]?.first
            case 2:
                leftLabel.text = CellText.costPerLaunch.rawValue
                rightlabel.text = dict[mainKey]?[Rockets.costPerLaunch.rawValue]?.first
            default:
                return
            }
        case 2:
            switch indexPath.item {
            case 0:
                leftLabel.text = CellText.engines.rawValue
                rightlabel.text = dict[mainKey]?[Rockets.firstStageEngines.rawValue]?.first
            case 1:
                leftLabel.text = CellText.fuelAmountTons.rawValue
                rightlabel.text = dict[mainKey]?[Rockets.firstStageFuelAmountTons.rawValue]?.first
            case 2:
                leftLabel.text = CellText.burnTimeSec.rawValue
                rightlabel.text = dict[mainKey]?[Rockets.firstStageBurnTimeSEC.rawValue]?.first
            default:
                return
            }
        case 3:
            switch indexPath.item {
            case 0:
                leftLabel.text = CellText.engines.rawValue
                rightlabel.text = dict[mainKey]?[Rockets.secondStageEngines.rawValue]?.first
            case 1:
                leftLabel.text = CellText.fuelAmountTons.rawValue
                rightlabel.text = dict[mainKey]?[Rockets.secondStageFuelAmountTons.rawValue]?.first
            case 2:
                leftLabel.text = CellText.burnTimeSec.rawValue
                rightlabel.text = dict[mainKey]?[Rockets.secondStageBurnTimeSEC.rawValue]?.first
            default:
                return
            }
        default:
            print("error")
        }
    }
}

