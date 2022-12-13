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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    var rocketIndexPath: Int = 0
    
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
        collectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Header.identifier)
        collectionView.register(RocketInfoCell.self, forCellWithReuseIdentifier: RocketInfoCell.identifier)
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
            rocketName.widthAnchor.constraint(equalToConstant: 146),
            rocketName.heightAnchor.constraint(equalToConstant: 36)
        ]
        let settingsButtonConstraints = [
            settingsButton.heightAnchor.constraint(equalToConstant: 32),
            settingsButton.widthAnchor.constraint(equalToConstant: 32),
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ]
        let collectionViewConstraints = [
            collectionView.topAnchor.constraint(equalTo: rocketName.bottomAnchor),
            // make bottom space for button
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(rocketNameConstraints)
        NSLayoutConstraint.activate(settingsButtonConstraints)
        NSLayoutConstraint.activate(collectionViewConstraints)
    }
    @objc func settingsPressed() {
        let settingsViewController = SettingsViewController()
        let navController = UINavigationController(rootViewController: settingsViewController)
        self.present(navController, animated: true)
    }
    private func firstSectionLayout() -> NSCollectionLayoutSection {
        let spacing: CGFloat = 6
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(116), heightDimension: .absolute(116))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.top = 32
//        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                heightDimension: .estimated(60.0))
//        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
//                                                                 elementKind: UICollectionView.elementKindSectionHeader,
//                                                                 alignment: .top)
        section.orthogonalScrollingBehavior = .continuous
//        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func secondSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(46))
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
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, enviroment) -> NSCollectionLayoutSection? in
            if sectionNumber ==  0 {
                return self.firstSectionLayout()
            } else if sectionNumber ==  1 {
                return self.secondSectionLayout()
            } else {
                return self.thirdSectionLayout()
            }
        }
    }
}

extension CollectionViewTest: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketInfoCell.identifier, for: indexPath) as? RocketInfoCell else { return UICollectionViewCell() }
        var titlesArray: [String] = []
        UnitTypes.allCases.forEach { title in
            titlesArray.append(title.rawValue)
        }
        cell.bindWithMedia(valueForUnit: "Hello", nameForUnitLabel: titlesArray[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                      withReuseIdentifier: Header.identifier,
                                                                                      for: indexPath) as? Header else {
                return UICollectionReusableView()
            }
            sectionHeader.label.text = "Header"
            return sectionHeader
        } else {
            return UICollectionReusableView()
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
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

let data = [String: [[String: [String]]]]()
