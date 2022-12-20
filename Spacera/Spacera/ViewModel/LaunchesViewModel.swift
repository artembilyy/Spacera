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
    private(set) var namesArray: [String] = []
    private(set) var datesArray: [String] = []
    private(set) var successArray: [Bool] = []
    weak var delegate: ViewModelProtocol?
    func getLaunches(mainKey: String) {
        namesArray.removeAll()
        datesArray.removeAll()
        successArray.removeAll()
        delegate?.showLoading()
        networkManager.getLaunchesInfo { result in
            for rocketID in result where mainKey == rocketID.rocket! {
                if let success = rocketID.success,
                   let name = rocketID.name,
                   let date = rocketID.dateLocal {
                    self.namesArray.append(name)
                    self.datesArray.append(date)
                    self.successArray.append(success)
                }
            }
            self.namesArray.reverse()
            self.datesArray.reverse()
            self.successArray.reverse()
            self.delegate?.hideLoading()
            self.delegate?.updateView()
        }
    }
}
