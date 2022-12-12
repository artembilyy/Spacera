//
//  SettingsView.swift
//  Spacera
//
//  Created by Artem Bilyi on 12.12.2022.
//

import UIKit

final class SettingsItemView: UIView {
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
        segmentedControl.addTarget(nil, action: #selector(segmetntedControlChanged), for: .valueChanged)
        segmentedControl.backgroundColor = UIColor(red: 33, green: 33, blue: 33, alpha: 1)
        segmentedControl.selectedSegmentTintColor = UIColor.white
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 142, green: 142, blue: 143, alpha: 1)], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 18, green: 18, blue: 18, alpha: 1)], for: .selected)
        return segmentedControl
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, unitSegmentedControl])
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI() {
        addSubview(stackView)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    private func setupConstraints() {
        let segmentedConstraints = [
            unitSegmentedControl.widthAnchor.constraint(equalToConstant: 200),
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
    @objc
    private func segmetntedControlChanged() {
        print("Pressed")
    }
}
