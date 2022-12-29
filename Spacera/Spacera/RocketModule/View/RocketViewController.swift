//
//  RocketViewController.swift
//  Spacera
//
//  Created by Artem Bilyi on 28.12.2022.
//

import UIKit

class RocketViewController: UIViewController {
    var presenter: RocketViewPresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.showText()
        view.backgroundColor = .purple
    }
}

extension RocketViewController: RocketViewProtocol {
    func sayHello(text: String) {
        print("hello")
    }
}
