//
//  CollectionViewTest.swift
//  Spacera
//
//  Created by Artem Bilyi on 11.12.2022.
//

import UIKit

class CollectionViewTest: UIViewController {
    private lazy var viewModel = RocketsViewModel()
    private let rocketName: UILabel = {
        $0.backgroundColor = .clear
        $0.text = ""
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        $0.textColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false
        //        $0.font = UIFont(name: "LabGrotesque-Medium", size: 24)
        return $0
    }(UILabel())
    
    private let settingsButton: UIImageView = {
        $0.image = UIImage(systemName: "gearshape")
        $0.tintColor = UIColor(red: 0.792, green: 0.792, blue: 0.792, alpha: 1)
        $0.contentMode = .scaleAspectFill
        $0.isUserInteractionEnabled = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .black
        collectionView.bounces = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    var rocketIndexPath: Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getRockets()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupLayout()
    }
    private func getRockets() {
        viewModel.getRockets()
    }
    
    private func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel.delegate = self
        collectionView.register(RocketMainCell.self, forCellWithReuseIdentifier: RocketMainCell.identifier)
        collectionView.register(RocketInfoCell.self, forCellWithReuseIdentifier: RocketInfoCell.identifier)
        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: ButtonCell.identifier)
        collectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Header.identifier)
        view.backgroundColor = .black
        view.addSubview(rocketName)
        view.addSubview(settingsButton)
        view.addSubview(collectionView)
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(settingsPressed))
        settingsButton.addGestureRecognizer(tapAction)
    }
    private func setupLayout() {
        let rocketNameConstraints = [
            rocketName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            rocketName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            rocketName.widthAnchor.constraint(equalToConstant: 170),
            rocketName.heightAnchor.constraint(equalToConstant: 36)
        ]
        let settingsButtonConstraints = [
            settingsButton.heightAnchor.constraint(equalToConstant: 32),
            settingsButton.widthAnchor.constraint(equalToConstant: 32),
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ]
        let collectionViewConstraints = [
            collectionView.topAnchor.constraint(equalTo: rocketName.bottomAnchor, constant: 32),
            // make bottom space for button
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(rocketNameConstraints)
        NSLayoutConstraint.activate(settingsButtonConstraints)
        NSLayoutConstraint.activate(collectionViewConstraints)
    }
    @objc
    private func settingsPressed() {
        let settingsViewController = SettingsViewController()
        let navController = UINavigationController(rootViewController: settingsViewController)
        self.present(navController, animated: true)
    }
    private func firstSectionLayout() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                          heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                     leading: 4,
                                                     bottom: 8,
                                                     trailing: 4)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(120),
                                               heightDimension: .absolute(130))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 8,
                                                      leading: 4,
                                                      bottom: 8,
                                                      trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        return section
    }
    
    private func secondSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(46))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.top = 24
        return section
    }
    
    private func thirdSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(46))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(60.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return section
    }
    private func fourthSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.top = 24
        return section
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, enviroment) -> NSCollectionLayoutSection? in
            if sectionNumber ==  0 {
                return self.firstSectionLayout()
            } else if sectionNumber == 1 {
                return self.secondSectionLayout()
            } else if sectionNumber == 4 {
                return self.fourthSectionLayout()
            } else {
                return self.thirdSectionLayout()
            }
        }
    }
}

extension CollectionViewTest: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketMainCell.identifier,
                                                            for: indexPath) as? RocketMainCell else { return UICollectionViewCell() }
        guard let secondCell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketInfoCell.identifier,
                                                                  for: indexPath) as? RocketInfoCell else { return UICollectionViewCell() }
        guard let buttonCell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCell.identifier, for: indexPath) as? ButtonCell else { return UICollectionViewCell() }
        switch indexPath.section {
        case 0:
            cell.configureCell(dictionary: viewModel.rocketsData, mainKey: rocketName.text ?? "", switchUnit: 1, indexPath: indexPath)
            return cell
        case 1:
            secondCell.configureCell(dict: viewModel.rocketsData, mainKey: rocketName.text ?? "", indexPath: indexPath)
            return secondCell
        case 2:
            secondCell.configureCell(dict: viewModel.rocketsData, mainKey: rocketName.text ?? "", indexPath: indexPath)
            return secondCell
        case 3:
            secondCell.configureCell(dict: viewModel.rocketsData, mainKey: rocketName.text ?? "", indexPath: indexPath)
            return secondCell
        case 4:
            var key = viewModel.rocketName[self.rocketIndexPath]
            buttonCell.key = viewModel.rocketsData[key]?[Rockets.id.rawValue]?[0] ?? ""
            buttonCell.viewController = self
            return buttonCell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                      withReuseIdentifier: Header.identifier,
                                                                                      for: indexPath) as? Header else {
                return UICollectionReusableView()
            }
            if indexPath.section == 2 {
                sectionHeader.label.text = RocketViewText.firstStage.rawValue
            } else if indexPath.section == 3 {
                sectionHeader.label.text = RocketViewText.secondStage.rawValue
            }
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1, 2, 3:
            return 3
        default:
            return 1
        }
    }
}

extension CollectionViewTest: UICollectionViewDelegate {
}

extension CollectionViewTest: ViewModelProtocol {
    func updateView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.rocketName.text = self.viewModel.rocketName[self.rocketIndexPath]
        }
    }
}
