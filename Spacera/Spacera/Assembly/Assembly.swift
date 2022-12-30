//
//  AssemblyBuilder.swift
//  Spacera
//
//  Created by Artem Bilyi on 28.12.2022.
//

import UIKit

protocol AssemblyBuilderProtocol {
    static func createRocketModule() -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {

    static func createRocketModule() -> UIViewController {
        let networkService = NetworkService()
        let view = RocketViewController()
        let presenter = RocketPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
}
