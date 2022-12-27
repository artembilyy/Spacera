//
//  DetailsViewController.swift
//  Spacera
//
//  Created by Artem Bilyi on 15.12.2022.
//

import UIKit

final class DetailtsViewController: UIViewController {
    // MARK: - View model
    private lazy var viewModel = LaunchesViewModel()
    // MARK: - loader
    private let child = LoadingViewController()
    // MARK: - Init Prop
    let launchType: String
    let navigationTitle: String
    init(key: String, title: String) {
        self.launchType = key
        self.navigationTitle = title
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // collection
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .black
        collectionView.bounces = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getLaunches(mainKey: launchType)
    }
    override func viewWillLayoutSubviews() {
        setupLayout()
    }
    // MARK: - Setup UI
    // delegate
    private func delegate() {
        viewModel.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LaunchCell.self,
                                forCellWithReuseIdentifier: LaunchCell.identifier)
    }
    // UI
    private func setupUI() {
        title = navigationTitle
        navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barStyle = UIBarStyle.black
                navigationController?.navigationBar.tintColor = UIColor.white
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
        view.addSubview(collectionView)
    }
    // MARK: - Setup Layout
    private func setupLayout() {
        child.view.frame = view.frame
        collectionView.frame = view.bounds
    }
    // collection view layout
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (_, _) -> NSCollectionLayoutSection? in
            return self.collectionView.laucnhSectionLayout()
        }
    }
}
// MARK: - Data Source
extension DetailtsViewController: UICollectionViewDataSource {
    // MARK: Sections num
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if viewModel.launches.isEmpty == true {
            return 1
        } else {
            return viewModel.launches.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    // MARK: Return Cell
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchCell.identifier,
                                                            for: indexPath) as? LaunchCell else {
            return UICollectionViewCell()
        }
        if viewModel.launches.isEmpty == true {
            cell.emptyData()
        } else {
            cell.configureCell(launch: viewModel.launches[indexPath.section])
        }
        return cell
    }
}
// MARK: - Collection Delegate
extension DetailtsViewController: UICollectionViewDelegate {
}
// MARK: - ViewModelProtocol
extension DetailtsViewController: ViewModelProtocol {
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
