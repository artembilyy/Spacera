//
//  SettingsView.swift
//  Spacera
//
//  Created by Artem Bilyi on 12.12.2022.
//

import UIKit

final class SettingsItemView: UIView {
    // MARK: - Setup UI
    lazy var titleLabel: UILabel = {
        $0.textColor = .white
        $0.textAlignment = .left
        $0.text = "Test"
        $0.clipsToBounds = true
        return $0
    }(UILabel())
    lazy var unitSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["", ""])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(nil,
                                   action:
                                    #selector(segmetntedControlChanged),
                                   for: .valueChanged)
        segmentedControl.backgroundColor = Fonts.customLightBlack.color
        segmentedControl.selectedSegmentTintColor = UIColor.white
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Fonts.customMidGray.color],
                                                for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Fonts.customBlack.color],
                                                for: .selected)
        return segmentedControl
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                       unitSegmentedControl])
        stackView.axis = .horizontal
        stackView.spacing = 28
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    var segmentedAction: (() -> Void)?
    // MARK: - Assembly
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    // MARK: - Configure
    private func setupUI() {
        addSubview(stackView)
    }
    // MARK: - SetupConstraints
    private func setupConstraints() {
        let segmentedConstraints = [
            unitSegmentedControl.widthAnchor.constraint(equalToConstant: 115)
        ]
        let stackViewConstraints = [
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                               constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                constant: -16),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(segmentedConstraints)
        NSLayoutConstraint.activate(stackViewConstraints)
    }
    // MARK: - Value Changed SegmentedControl
    @objc
    private func segmetntedControlChanged(sender: UISegmentedControl) {
        segmentedAction?()
    }
}
