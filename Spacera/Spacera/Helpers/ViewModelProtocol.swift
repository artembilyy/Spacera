//
//  ViewModelProtocol.swift
//  Spacera
//
//  Created by Artem Bilyi on 11.12.2022.
//

import Foundation
// MARK: - ViewModelProtocol
protocol ViewModelProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func updateView()
}

extension ViewModelProtocol {
    func showLoading() { }
    func hideLoading() { }
    func updateView() { }
}
