//
//  CollectionViewTest.swift
//  Spacera
//
//  Created by Artem Bilyi on 11.12.2022.
//

import UIKit

class RocketViewController: UIViewController {
    // MARK: - View model
    private lazy var viewModel = RocketViewModel()
    // MARK: - Name for key
    private var rocketNames: [String] = []
    // MARK: - Index of page
    private var selectedRocketIndex: Int!
    init(index: Int) {
        self.selectedRocketIndex = index
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // collection view
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .black
        collectionView.bounces = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate()
        setupUI()
        fetchRockets()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupLayout()
    }
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        ignoreSafeAre()
    }
    // MARK: - Network request
    private func fetchRockets() {
        viewModel.fetchRockets()
    }
    // MARK: - Setup UI
    private func ignoreSafeAre() {
        var insets = view.safeAreaInsets
        insets.top = 0
        collectionView.contentInset = insets
    }
    private func delegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel.delegate = self
    }
    private func setupUI() {
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(ImageCell.self,
                                forCellWithReuseIdentifier: ImageCell.identifier)
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
        view.addSubview(collectionView)
    }
    // MARK: - Setup Layout
    private func setupLayout() {
        let collectionViewConstraints = [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(collectionViewConstraints)
    }
    // MARK: - Configure Compositional layout
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            switch sectionNumber {
            case 0:
                return self.collectionView.imageSectionLayout()
            case 1:
                return self.collectionView.titleSectionLayout()
            case 2:
                return self.collectionView.firstSectionLayout()
            case 3:
                return self.collectionView.secondSectionLayout()
            case 6:
                return self.collectionView.fourthSectionLayout()
            default:
                return self.collectionView.thirdSectionLayout()
            }
        }
    }
}
// MARK: - Data Source
extension RocketViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        7
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
        guard let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier,
                                                                 for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }
        switch indexPath.section {
        case 0:
            imageCell.configureCell(dict: viewModel.rocketsData,
                                    mainKey: rocketNames[selectedRocketIndex])
            return imageCell
        case 1:
            titleCell.configureCell(name: rocketNames[selectedRocketIndex])
            titleCell.viewController = self
            return titleCell
        case 2:
            cell.configureCell(dictionary: viewModel.rocketsData,
                               mainKey: rocketNames[selectedRocketIndex],
                               switchUnit: 1,
                               indexPath: indexPath)
            return cell
        case 3, 4, 5:
            secondCell.configureCell(dict: viewModel.rocketsData,
                                     mainKey: rocketNames[selectedRocketIndex],
                                     indexPath: indexPath)
            return secondCell
        case 6:
            buttonCell.key = viewModel.rocketsData[rocketNames[selectedRocketIndex]]?[Rockets.id.rawValue]?[0] ?? ""
            buttonCell.title = rocketNames[selectedRocketIndex]
            buttonCell.viewController = self
            return buttonCell
        default:
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: Header.identifier,
                                                                               for: indexPath) as? Header else {
                return UICollectionReusableView()
            }
            if indexPath.section == 4 {
                header.label.attributedText = NSAttributedString(string: RocketViewText.firstStage.rawValue)
            } else if indexPath.section == 5 {
                header.label.attributedText = NSAttributedString(string: RocketViewText.secondStage.rawValue)
            }
            return header
        }
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if viewModel.rocketsData.isEmpty == false {
            switch section {
            case 0, 1:
                return 1
            case 2:
                return 4
            case 3, 4, 5:
                return 3
            default:
                return 1
            }
        } else {
            return 0
        }
    }
}
// MARK: - ViewModeProtocol
extension RocketViewController: ViewModelProtocol {
    // MARK: - Reload Data
    func updateView() {
        DispatchQueue.main.async { [self] in
            rocketNames = viewModel.rocketName
            collectionView.reloadData()
        }
    }
}

extension RocketViewController: UICollectionViewDelegate {
    //
}
