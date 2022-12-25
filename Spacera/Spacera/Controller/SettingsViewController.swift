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
        configureSegmentedControls()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSegmentedControls()
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
        navigationController?.navigationBar.titleTextAttributes =
                                                                [NSAttributedString.Key.foregroundColor: UIColor.white]
        title = "Settings"
    }
    private func setupSegmentedControls() {
        for (index, view) in settingsItems.enumerated() {
            selectedSegmentedIndex(index: index, view: view)
        }
    }
    private func selectedSegmentedIndex(index: Int, view: UIView) {
        guard let view = view as? SettingsItemView else { return }
        switch index {
        case 0:
            if UserDefaults.standard.string(forKey: RocketUnit.height.rawValue) == UnitType.m.rawValue {
                view.unitSegmentedControl.selectedSegmentIndex = 0
            } else {
                view.unitSegmentedControl.selectedSegmentIndex = 1
            }
        case 1:
            if UserDefaults.standard.string(forKey: RocketUnit.diameter.rawValue) == UnitType.m.rawValue {
                view.unitSegmentedControl.selectedSegmentIndex = 0
            } else {
                view.unitSegmentedControl.selectedSegmentIndex = 1
            }
        case 2:
            if UserDefaults.standard.string(forKey: RocketUnit.weight.rawValue) == UnitType.kg.rawValue {
                view.unitSegmentedControl.selectedSegmentIndex = 0
            } else {
                view.unitSegmentedControl.selectedSegmentIndex = 1
            }
        case 3:
            if UserDefaults.standard.string(forKey: RocketUnit.payload.rawValue) == UnitType.kg.rawValue {
                view.unitSegmentedControl.selectedSegmentIndex = 0
            } else {
                view.unitSegmentedControl.selectedSegmentIndex = 1
            }
        default:
            return
        }
    }
    private func configureSegmentedControls() {
        for (index, view) in settingsItems.enumerated() {
            setAction(index: index, view: view) { completion in
                switch index {
                case 0:
                    if completion == 0 {
                        UserDefaults.standard.set(UnitType.m.rawValue, forKey: RocketUnit.height.rawValue)
                    } else {
                        UserDefaults.standard.set(UnitType.ft.rawValue, forKey: RocketUnit.height.rawValue)
                    }
                case 1:
                    if completion == 0 {
                        UserDefaults.standard.set(UnitType.m.rawValue, forKey: RocketUnit.diameter.rawValue)
                    } else {
                        UserDefaults.standard.set(UnitType.ft.rawValue, forKey: RocketUnit.diameter.rawValue)
                    }
                case 2:
                    if completion == 0 {
                        UserDefaults.standard.set(UnitType.kg.rawValue, forKey: RocketUnit.weight.rawValue)
                    } else {
                        UserDefaults.standard.set(UnitType.lb.rawValue, forKey: RocketUnit.weight.rawValue)
                    }
                case 3:
                    if completion == 0 {
                        UserDefaults.standard.set(UnitType.kg.rawValue, forKey: RocketUnit.payload.rawValue)
                    } else {
                        UserDefaults.standard.set(UnitType.lb.rawValue, forKey: RocketUnit.payload.rawValue)
                    }
                default: break
                }
            }
        }
    }
    private func setAction(index: Int, view: UIView, completion: @escaping (Int) -> Void) {
        guard let view = view as? SettingsItemView else { return }
        view.action = { [weak self] in
            switch view.unitSegmentedControl.selectedSegmentIndex {
            case let index where index == 0:
                completion(index)
            case let index where index == 1:
                completion(index)
            default: break
            }
            self?.reloadData()
        }
    }
    private func reloadData() {
        NotificationCenter.default.post(name: NotificationObserver.reloadData, object: nil)
    }
    // MARK: - Dismiss
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
