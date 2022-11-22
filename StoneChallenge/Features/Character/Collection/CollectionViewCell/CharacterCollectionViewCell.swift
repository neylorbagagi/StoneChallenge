//
//  CharacterCollectionViewCell.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 15/11/22.
//

import UIKit
import RxSwift

class CharacterCollectionViewCell: UICollectionViewCell {

    var disposeBag = DisposeBag()

    // MARK: - VIEWS
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints  = false
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProText-Thin", size: 14)
        label.textColor = #colorLiteral(red: 0.03137254902, green: 0.03137254902, blue: 0.03137254902, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.7412293553, green: 1, blue: 0.631372549, alpha: 1)
        label.text = viewModel?.name
        return label
    }()

    // MARK: - PUBLIC PROPERTIES
    static let reuseIdentifier = "CharacterCollectionViewCell"

    // MARK: - INJECTED PROPERTIES
    var viewModelProvider: CharacterCollectionViewModelProvider?
    var viewModel: CharacterCollectionViewModel?

    // MARK: - CONSTRUCTORS
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.nameLabel)

        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -6),
            self.nameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -6),
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) { return nil }

    // MARK: - OVERRIDES
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
        imageView.image = nil
        disposeBag = DisposeBag()
    }

    // MARK: - BIND
    func bind() {
        viewModel?.image
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
    }

    // MARK: - PUBLIC FUNCTIONS
    public func configure(viewModel: CharacterCollectionViewModel) {
        self.viewModel = viewModel
        nameLabel.text = viewModel.name
        bind()
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct CharacterCollectionViewCell_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World!")
    }
}
#endif
