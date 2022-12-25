//
//  LaunchesViewModel.swift
//  Spacera
//
//  Created by Artem Bilyi on 11.12.2022.
//

import Foundation

final class LaunchesViewModel {
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    private(set) var launches: [Launch] = []
    weak var delegate: ViewModelProtocol?
    func getLaunches(mainKey: String) {
        delegate?.showLoading()
        networkManager.getLaunchesInfo { result in
            self.launches = result.filter({ launch in
                mainKey == launch.rocket
            })
            self.launches.reverse()
            self.delegate?.updateView()
            self.delegate?.hideLoading()
        }
    }
}
