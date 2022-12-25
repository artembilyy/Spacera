//
//  DetailsViewController.swift
//  Spacera
//
//  Created by Artem Bilyi on 15.12.2022.
//

import UIKit

class DetailtsViewController: UIViewController {
    // MARK: - View model
    private lazy var viewModel = LaunchesViewModel()
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
    // MARK: - Setup UI
    private func delegate() {
        viewModel.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LaunchCell.self,
                                forCellWithReuseIdentifier: LaunchCell.identifier)
    }
    private func setupUI() {
        title = navigationTitle
        navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.white]
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
    }
    // layout
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (_, _) -> NSCollectionLayoutSection? in
            return self.collectionView.laucnhSectionLayout()
        }
    }
}
// MARK: - Data Source
extension DetailtsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if viewModel.launches.isEmpty == true {
            return 1
        } else {
            return viewModel.launches.count
        }
    }
}
// MARK: - Collection Delegate
extension DetailtsViewController: UICollectionViewDelegate {
}
// MARK: - ViewModelProtocol
extension DetailtsViewController: ViewModelProtocol {
    func showLoading() {
        view.bringSubviewToFront(child.view)
    }
    func hideLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.child.willMove(toParent: nil)
            self.child.view.removeFromSuperview()
            self.child.removeFromParent()
        }
    }
    func updateView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
