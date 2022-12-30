//
//  LaunchPresenter.swift
//  Spacera
//
//  Created by Artem Bilyi on 30.12.2022.
//

import Foundation

protocol LaunchViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol LaunchViewPresenterProtocol: AnyObject {
    init(view: LaunchViewProtocol, networkService: NetworkServiceProtocol)
    func getRockets()
    var launches: [Launch]? { get set }
}

class LaunchPresenter: RocketViewPresenterProtocol {
    var rockets: [Rocket]?
    
    weak var view: RocketViewProtocol?
    let networkService: NetworkServiceProtocol!
    required init(view: RocketViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
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
}

