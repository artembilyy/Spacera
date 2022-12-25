//
//  RocketsViewModel.swift
//  Spacera
//
//  Created by Artem Bilyi on 11.12.2022.
//

import Foundation

final class RocketViewModel {
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    private(set) var rockets: [Rocket] = []
    weak var delegate: ViewModelProtocol?
    func fetchRockets() {
        delegate?.showLoading()
        networkManager.getRocketsInfo { result in
            self.rockets = result
            self.delegate?.updateView()
            self.delegate?.hideLoading()
        }
    }
}
