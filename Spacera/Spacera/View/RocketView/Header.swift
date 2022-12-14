//
//  Header.swift
//  Spacera
//
//  Created by Artem Bilyi on 12.12.2022.
//

import UIKit

final class Header: UICollectionViewCell {
    // MARK: - Init UI
    static let identifier = "headerIdentifier"
    private let contrainer = UIView()
    let label = UILabel()
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
        setupConstraint()
    }
    // MARK: - Configure UI
    private func configureView() {
        contrainer.backgroundColor = .clear
        contrainer.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.setFont(name: LabGrotesque.bold.rawValue, size: 16)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .white
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        label.attributedText = NSMutableAttributedString(string: "",
                                                         attributes: [NSAttributedString.Key.paragraphStyle:
                                                                        paragraphStyle])
    }
    // MARK: - Constraints
    private func setupConstraint() {
        contentView.addSubview(contrainer)
        contrainer.addSubview(label)
        NSLayoutConstraint.activate([
            contrainer.widthAnchor.constraint(equalToConstant: contentView.bounds.width),
            contrainer.heightAnchor.constraint(equalToConstant: contentView.bounds.height),
            contrainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            contrainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contrainer.topAnchor),
            label.leadingAnchor.constraint(equalTo: contrainer.leadingAnchor, constant: 32),
            label.centerYAnchor.constraint(equalTo: contrainer.centerYAnchor)
        ])
    }
}
