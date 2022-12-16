//
//  DetailsViewController.swift
//  Spacera
//
//  Created by Artem Bilyi on 15.12.2022.
//

import UIKit

class DetailtsViewController: UIViewController {
    private lazy var viewModel = LaunchesViewModel()
    let mainKey: String
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .black
        collectionView.bounces = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    init(keyForDict: String) {
        self.mainKey = keyForDict
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getLaunches(mainKey: mainKey)
        viewModel.delegate = self
        view.backgroundColor = .systemRed
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LaunchCell.self, forCellWithReuseIdentifier: LaunchCell.identifier)
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (_, _) -> NSCollectionLayoutSection? in
            return self.collectionView.laucnhSectionLayout()
        }
    }
}

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
        cell.configureCell(name: viewModel.namesArray[indexPath.section],
                           date: viewModel.datesArray[indexPath.section],
                           success: viewModel.successArray[indexPath.section])
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.namesArray.count
    }
}

extension DetailtsViewController: UICollectionViewDelegate {
}

extension DetailtsViewController: ViewModelProtocol {
    func updateView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
