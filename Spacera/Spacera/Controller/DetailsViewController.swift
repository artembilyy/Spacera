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
        view.backgroundColor = .systemRed
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
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
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, enviroment) -> NSCollectionLayoutSection? in
            return self.firstSectionLayout()
        }
    }
}

extension DetailtsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.namesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchCell.identifier,
                                                            for: indexPath) as? LaunchCell else { return UICollectionViewCell() }
        cell.configureCell(name: viewModel.namesArray[indexPath.item], date: viewModel.datesArray[indexPath.row], success: viewModel.successArray[indexPath.item])
        return cell
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
