//
//  RocketPresenter.swift
//  Spacera
//
//  Created by Artem Bilyi on 28.12.2022.
//

import Foundation

protocol RocketViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol RocketViewPresenterProtocol: AnyObject {
    init(view: RocketViewProtocol, networkService: NetworkServiceProtocol)
    func getRockets()
    var rockets: [Rocket]? { get set }
}

class RocketPresenter: RocketViewPresenterProtocol {
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