//
//  CollectionViewTest.swift
//  Spacera
//
//  Created by Artem Bilyi on 11.12.2022.
//

import UIKit
import Kingfisher

class RocketViewController: UIViewController {
    private lazy var viewModel = RocketViewModel()
    lazy var backgroundImage: UIImageView = {
        $0.contentMode = .scaleToFill
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    private var index: Int = 0
    private var rocketNames: [String] = []
    init(index: Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .black
        collectionView.bounces = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
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
        backgroundImage.kf.indicatorType = .activity
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel.delegate = self
        collectionView.register(TitleCell.self,
                                forCellWithReuseIdentifier: TitleCell.identifier)
        collectionView.register(RocketMainCell.self,
                                forCellWithReuseIdentifier: RocketMainCell.identifier)
        collectionView.register(RocketInfoCell.self,
                                forCellWithReuseIdentifier: RocketInfoCell.identifier)
        collectionView.register(ButtonCell.self,
                                forCellWithReuseIdentifier: ButtonCell.identifier)
        collectionView.register(Header.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: Header.identifier)
        view.backgroundColor = .black
        view.addSubview(backgroundImage)
        view.addSubview(collectionView)
    }
    private func setupLayout() {
        let backgroundImageConstraints = [
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.heightAnchor.constraint(equalToConstant: view.frame.height / 2.2)
        ]
        let collectionViewConstraints = [
            collectionView.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -24),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(backgroundImageConstraints)
        NSLayoutConstraint.activate(collectionViewConstraints)
    }
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            if sectionNumber == 0 {
                return self.collectionView.titleSectionLayout()
            } else if sectionNumber == 1 {
                return self.collectionView.firstSectionLayout()
            } else if sectionNumber == 2 {
                return self.collectionView.secondSectionLayout()
            } else if sectionNumber == 5 {
                return self.collectionView.fourthSectionLayout()
            } else {
                return self.collectionView.thirdSectionLayout()
            }
        }
    }
}

extension RocketViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        6
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let titleCell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCell.identifier,
                                                                 for: indexPath) as? TitleCell else {
            return UICollectionViewCell()
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketMainCell.identifier,
                                                            for: indexPath) as? RocketMainCell else {
            return UICollectionViewCell()
        }
        guard let secondCell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketInfoCell.identifier,
                                                                  for: indexPath) as? RocketInfoCell else {
            return UICollectionViewCell()
        }
        guard let buttonCell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCell.identifier,
                                                                  for: indexPath) as? ButtonCell else {
            return UICollectionViewCell()
        }
        switch indexPath.section {
        case 0:
            titleCell.configureCell(name: rocketNames[index])
            titleCell.viewController = self
            return titleCell
        case 1:
            cell.configureCell(dictionary: viewModel.rocketsData,
                               mainKey: rocketNames[index],
                               switchUnit: 1,
                               indexPath: indexPath)
            return cell
        case 2, 3, 4:
            secondCell.configureCell(dict: viewModel.rocketsData,
                                     mainKey: rocketNames[index],
                                     indexPath: indexPath)
            return secondCell
        case 5:
            buttonCell.key = viewModel.rocketsData[rocketNames[index]]?[Rockets.id.rawValue]?[0] ?? ""
            buttonCell.viewController = self
            return buttonCell
        default:
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                      withReuseIdentifier: Header.identifier,
                                                                                      for: indexPath) as? Header else {
                return UICollectionReusableView()
            }
            if indexPath.section == 3 {
                header.label.text = RocketViewText.firstStage.rawValue
            } else if indexPath.section == 4 {
                header.label.text = RocketViewText.secondStage.rawValue
            }
            return header
        }
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if viewModel.rocketsData.isEmpty == false {
            switch section {
            case 1:
                return 4
            case 2, 3, 4:
                return 3
            default:
                return 1
            }
        } else {
            return 0
        }
    }
}

extension RocketViewController: UICollectionViewDelegate {
}

extension RocketViewController: ViewModelProtocol {
    func updateView() {
        DispatchQueue.main.async { [self] in
            rocketNames = viewModel.rocketName
            if let url = viewModel.rocketsData[rocketNames[index]]?[Rockets.images.rawValue]?.randomElement() {
                if let posterPath = URL(string: url) {
                    backgroundImage.kf.setImage(with: posterPath)
                }
            }
            collectionView.reloadData()
        }
    }
}
