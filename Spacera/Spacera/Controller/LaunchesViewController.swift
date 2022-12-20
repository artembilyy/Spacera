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
    // MARK: - Init Prop
    let launchType: String
    let navigationTitle: String
    init(keyForDict: String, title: String) {
        self.launchType = keyForDict
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
    }
    private func setupUI() {
        title = navigationTitle
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        view.backgroundColor = .systemRed
        collectionView.register(LaunchCell.self, forCellWithReuseIdentifier: LaunchCell.identifier)
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
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
        if viewModel.namesArray.isEmpty == true {
            cell.emptyData()
        } else {
            cell.configureCell(name: viewModel.namesArray[indexPath.section],
                               date: viewModel.datesArray[indexPath.section],
                               success: viewModel.successArray[indexPath.section])
        }
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if viewModel.namesArray.isEmpty == true {
            return 1
        } else {
            return viewModel.namesArray.count
        }
    }
}
// MARK: - Collection Delegate
extension DetailtsViewController: UICollectionViewDelegate {
}
// MARK: - ViewModelProtocol
extension DetailtsViewController: ViewModelProtocol {
    func updateView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
