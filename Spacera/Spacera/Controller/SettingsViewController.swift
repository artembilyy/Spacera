//
//  SettingsViewController.swift
//  Spacera
//
//  Created by Artem Bilyi on 12.12.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    // MARK: - Configure by for in
    private var settingsItems: [UIView] = []
    // stack view
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: settingsItems)
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupLayout()
    }
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
        UnitTypes.allCases.forEach {
            let settingView = SettingsItemView()
            settingView.unitSegmentedControl.setTitle($0.description[0], forSegmentAt: 0)
            settingView.unitSegmentedControl.setTitle($0.description[1], forSegmentAt: 1)
            settingView.titleLabel.text = $0.rawValue.capitalized
            settingsItems.append(settingView)
        }
        view.addSubview(stackView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(closeAction))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        title = "Settings"
    }
    // MARK: - Dissmiss
    @objc
    private func closeAction() {
        self.dismiss(animated: true)
    }
    // MARK: - Setup Layout
    private func setupLayout() {
        let stackViewConstraitns = [
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 56),
            stackView.heightAnchor.constraint(equalToConstant: 200),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28)
        ]
        NSLayoutConstraint.activate(stackViewConstraitns)
    }
}
