//
//  ViewController.swift
//  Spacera
//
//  Created by Artem Bilyi on 09.12.2022.
//

import UIKit

final class ViewController: UIViewController {
    // MARK: - UI Elements
    private let mainImage: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage(named: "main")
        return $0
    }(UIImageView())
    private let scrollView: UIScrollView = {
        $0.bounces = false
        $0.contentInsetAdjustmentBehavior = .never
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        return $0
    }(UIScrollView())
    
    private var test: [Rocket] = []
    private var test2: [Launch] = []
    private var rocketsID: [String] = []
    private var rocketsFromLaunch: [String] = []
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
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainImage)
        view.addSubview(scrollView)
    }
    // MARK: - Constraints
    private func setupLayout() {
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let mainImageConstraints = [
            mainImage.topAnchor.constraint(equalTo: view.topAnchor),
            mainImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(mainImageConstraints)
    }
}
