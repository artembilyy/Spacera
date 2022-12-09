//
//  ViewController.swift
//  Spacera
//
//  Created by Artem Bilyi on 09.12.2022.
//

import UIKit

final class ViewController: UIViewController {
    private lazy var mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "main")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemRed
        setupUI()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupLayout()
    }
    // MARK: - SetupUI
    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(mainImage)
    }
    // MARK: - Constraints
    private func setupLayout() {
        mainImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
