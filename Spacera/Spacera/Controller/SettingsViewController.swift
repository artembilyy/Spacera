//
//  SettingsViewController.swift
//  Spacera
//
//  Created by Artem Bilyi on 12.12.2022.
//

import UIKit

enum UnitTypes: Int, CaseIterable {
    case height = 0, diameter = 1, weight = 2, payload = 3
    var description: String {
        switch self {
        case .height:   return "height"
        case .diameter: return "diameter"
        case .weight:   return "weight"
        case .payload:  return "payload"
        }
    }
}

class SettingsViewController: UIViewController {
    
    private var segmentedArray: [UIView] = []
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: segmentedArray)
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupLayout()
    }
    private func setupUI() {
        view.backgroundColor = .black
        UnitTypes.allCases.forEach {
            let settingView = SettingsItemView()
            settingView.titleLabel.text = $0.description.capitalized
            settingView.unitSegmentedControl.insertSegment(withTitle: $0.description.capitalized, at: settingView.unitSegmentedControl.numberOfSegments, animated: false)
            segmentedArray.append(settingView)
        }
        view.addSubview(stackView)
    }
    private func setupLayout() {
        let stackViewConstraitns = [
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 400),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(stackViewConstraitns)
    }
}

