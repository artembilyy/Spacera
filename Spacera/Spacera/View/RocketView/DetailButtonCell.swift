//
//  DetailButtonCell.swift
//  Spacera
//
//  Created by Artem Bilyi on 14.12.2022.
//

import UIKit

final class ButtonCell: UICollectionViewCell {
    // MARK: identifier
    static let identifier = "buttonCell"
    // MARK: - UI Elements
    private let container = UIView()
    private let button = UIButton(type: .system)
    var key: String?
    var title: String?
    weak var viewController: RocketViewController?
    // MARK: - Assembly
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented - not using storyboards")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    // MARK: - Configure cell
    private func configureView() {
        contentView.addSubview(container)
        container.backgroundColor = .black
        container.translatesAutoresizingMaskIntoConstraints = false
        //
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.titleLabel?.font = UIFont.setFont(name: LabGrotesque.bold.rawValue, size: 16)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        let myAttributedTitle = NSAttributedString(string: "Show launches",
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        button.setAttributedTitle(myAttributedTitle, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.backgroundColor = Fonts.customGray.color.cgColor
        container.addSubview(button)
    }
    // MARK: - Cell contraints
    private func setupConstraints() {
        let contrainerConstraints = [
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        let buttonConstraints = [
            button.topAnchor.constraint(equalTo: container.topAnchor),
            button.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 32),
            button.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -32),
            button.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ]
        NSLayoutConstraint.activate(contrainerConstraints)
        NSLayoutConstraint.activate(buttonConstraints)
    }
    // MARK: - Push VC Action
    @objc
    private func buttonAction() {
        if let title = title,
           let key = key {
            let detailsViewController = DetailtsViewController(key: key, title: title)
            viewController?.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
}
