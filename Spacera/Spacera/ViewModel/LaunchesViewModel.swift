//
//  LaunchesViewModel.swift
//  Spacera
//
//  Created by Artem Bilyi on 11.12.2022.
//

import Foundation

enum Launches: String {
    case id, name, date, success
}

final class LaunchesViewModel {
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    private(set) var launches: [Launch] = []
    private(set) var launchesData: [String: [Any]] = [:]
    private(set) var namesArray: [String] = []
    private(set) var datesArray: [String] = []
    private(set) var successArray: [Bool] = []
    weak var delegate: ViewModelProtocol?
    
    func getLaunches(mainKey: String, indexPath: IndexPath) {
        namesArray.removeAll()
        datesArray.removeAll()
        successArray.removeAll()
        delegate?.showLoading()
        networkManager.getLaunchesInfo { result in
            self.launches = result
            for rocketID in self.launches where mainKey == rocketID.rocket! {
                if let success = rocketID.success,
                   let name = rocketID.name,
                   let date = rocketID.date_local {
                    self.namesArray.append(name)
                    self.datesArray.append(date)
                    self.successArray.append(success)
//                    self.launchesData[[name]] += success
//                    self.launchesData[[identifier]] += name
//                    self.launchesData[[identifier]] += date
//                    self.smallDict.updateValue(identifier, forKey: Launches.id.rawValue)
//                    self.smallDict[Launches.success.rawValue]!.append(success)
//                    self.smallDict.updateValue(name, forKey: Launches.name.rawValue)
//                    self.smallDict[Launches.name.rawValue]!.append(name)
//                    self.smallDict.updateValue(date, forKey: Launches.date.rawValue)
//                    self.smallDict[Launches.date.rawValue]!.append(date)
                }
            }
            self.delegate?.hideLoading()
            self.delegate?.updateView()
        }
    }
}
