//
//  CollectionViewTest.swift
//  Spacera
//
//  Created by Artem Bilyi on 11.12.2022.
//

import UIKit

final class RocketViewController: UIViewController {
    // MARK: - View model
    private lazy var viewModel = RocketViewModel()
    // MARK: - loader
    private let child = LoadingViewController()
    // MARK: - Index of page
    private var rocketIndex: Int!
    // switch rockets by index
    init(index: Int) {
        self.rocketIndex = index
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Collection View
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
    // top safe area
    private func ignoreSafeAre() {
        var insets = view.safeAreaInsets
        insets.top = 0
        collectionView.contentInset = insets
    }
    // delegate
    private func delegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel.delegate = self
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadData),
                                               name: NotificationObserver.reloadData,
                                               object: nil)
    }
    // UI
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
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
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
    // MARK: - Call by Notification
    @objc
    private func reloadData() {
        DispatchQueue.main.async { [unowned self] in
            collectionView.reloadData()
        }
    }
}
// MARK: - Data Source
extension RocketViewController: UICollectionViewDataSource {
    // MARK: Sections num
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        7
    }
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if viewModel.rockets.isEmpty == false {
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
    // MARK: Return Cell
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
        // configure cells
        switch indexPath.section {
        case 0:
            imageCell.configureCell(rocket: viewModel.rockets[rocketIndex])
            return imageCell
        case 1:
            titleCell.configureCell(rocket: viewModel.rockets[rocketIndex])
            titleCell.viewController = self
            return titleCell
        case 2:
            cell.configureCell(rocket: viewModel.rockets[rocketIndex],
                               indexPath: indexPath)
            return cell
        case 3, 4, 5:
            secondCell.configureCell(rocket: viewModel.rockets[rocketIndex],
                                     indexPath: indexPath)
            return secondCell
        case 6:
            if let key = viewModel.rockets[rocketIndex].id {
                buttonCell.key = key
            }
            if let title = viewModel.rockets[rocketIndex].name {
                buttonCell.title = title
            }
            buttonCell.viewController = self
            return buttonCell
        default:
            return UICollectionViewCell()
        }
    }
    // MARK: Headers for sections
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
                header.label.attributedText = NSAttributedString(string: RocketUnit.firstStage.rawValue)
            } else if indexPath.section == 5 {
                header.label.attributedText = NSAttributedString(string: RocketUnit.secondStage.rawValue)
            }
            return header
        }
        return UICollectionReusableView()
    }
}
// MARK: - ViewModeProtocol
extension RocketViewController: ViewModelProtocol {
    // MARK: Show indicator
    func showLoading() {
        view.bringSubviewToFront(child.view)
    }
    // MARK: Hide indicator
    func hideLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [unowned self] in
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
    // MARK: Reload Data
    func updateView() {
        DispatchQueue.main.async { [unowned self] in
            collectionView.reloadData()
        }
    }
}

extension RocketViewController: UICollectionViewDelegate {
    //
}
