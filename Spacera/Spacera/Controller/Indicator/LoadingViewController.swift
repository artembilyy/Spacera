//
//  LoadingViewController.swift
//  Spacera
//
//  Created by Artem Bilyi on 25.12.2022.
//
import UIKit

class LoadingViewController: UIViewController {
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        return spinner
    }()
    // UI
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = .black
        view.addSubview(spinner)
    }
    override func viewWillLayoutSubviews() {
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
