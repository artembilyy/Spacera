//
//  PageControlPresenter.swift
//  Spacera
//
//  Created by Artem Bilyi on 02.01.2023.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    var rockets: [Rocket]? { get set }
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, dataManager: RealmManagerProtocol)
    func getRockets() // make REALM
}

class MainPresenter: MainViewPresenterProtocol {
    
    var rockets: [Rocket]?
    weak var view: MainViewProtocol?
    private let dataManager: RealmManagerProtocol
    let networkService: NetworkServiceProtocol!
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, dataManager: RealmManagerProtocol) {
        self.view = view
        self.networkService = networkService
        self.dataManager = dataManager
        getRockets()
    }
    
    func getRockets() {
        networkService.getRockets { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let rockets):
                    self.rockets = rockets
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    func saveRockets(rocket: [RocketRealm]) {
        do {
            try dataManager.saveRocket(data: rocket)
        } catch {
            debugPrint("Error")
        }
    }
    
    func deleteRockets(rocket: [RocketRealm]) {
        do {
            try dataManager.deleteRocket(data: rocket)
        } catch {
            debugPrint("Error")
        }
    }
//
//    func fetchRockets(rocket: [RocketRealm]) -> RocketRealm {
//        let a = dataManager.fetchTasks()
//        return a
//    }
}
//    func showLaunches(rocketID: String?) {
//        router?.lauchesViewController(rocketID: rocketID)
//    }

