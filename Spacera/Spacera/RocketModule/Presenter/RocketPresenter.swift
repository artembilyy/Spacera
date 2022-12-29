//
//  RocketPresenter.swift
//  Spacera
//
//  Created by Artem Bilyi on 28.12.2022.
//

import Foundation

protocol RocketViewProtocol: AnyObject {
    func sayHello(text: String)
}

protocol RocketViewPresenterProtocol: AnyObject {
    init(view: RocketViewProtocol, rockets: [Rocket])
    func showText()
}

class RocketPresenter: RocketViewPresenterProtocol {
    
    let view: RocketViewProtocol?
    var rockets: [Rocket] = []
    required init(view: RocketViewProtocol, rockets: [Rocket]) {
        self.view = view
        self.rockets = rockets
    }
    
    func showText() {
        self.view?.sayHello(text: "Show text")
    }
}
