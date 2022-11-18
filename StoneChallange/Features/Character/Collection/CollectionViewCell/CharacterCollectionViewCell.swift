//
//  CharacterCollectionViewCell.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 15/11/22.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {

    // MARK: - VIEWS
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints  = false
        return imageView
    }()

    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProText-Thin", size: 14)
        label.textColor = #colorLiteral(red: 0.1764705882, green: 0.1882352941, blue: 0.2784313725, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.8078431373, blue: 0.3568627451, alpha: 1)
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

        self.contentView.addSubview(self.title)
        self.contentView.addSubview(self.imageView)

        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),

            self.title.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.title.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.title.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.title.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }

//    init(viewModelProvider: CharacterCollectionViewModelProvider) {
//        self.viewModelProvider = viewModelProvider
//        self.viewModel = viewModelProvider.viewModel
//        super.init(frame: .zero)
//
//        configure()
//    }

    required init?(coder: NSCoder) { return nil }

    // MARK: - OVERRIDES
    override func prepareForReuse() {
        super.prepareForReuse()
        //hide or reset anything you want hereafter, for example
        title.text = ""
    }

    // MARK: - PRIVATE FUNCTIONS
//    private func configure() {
//        self.contentView.addSubview(self.title)
//        self.contentView.addSubview(self.imageView)
//
//        NSLayoutConstraint.activate([
//            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
//            self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
//            self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
//            self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
//
//            self.title.topAnchor.constraint(equalTo: self.contentView.topAnchor),
//            self.title.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
//            self.title.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
//            self.title.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
//        ])
//    }

    // MARK: - PUBLIC FUNCTIONS
    public func configure(viewModel: CharacterCollectionViewModel) { // MUST TO CHENGE THIS NAME
        title.text = viewModel.name
    }
}

//#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//struct CharacterCollectionViewCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewPreview {
//            CharacterCollectionViewCell(
//                viewModelProvider: CharacterCollectionViewPresenter(
//                    character: Character(
//                        id: 1006,
//                        name: "Gabriela",
//                        status: "Gabriela",
//                        species: "Gabriela",
//                        type: "Gabriela",
//                        gender: "Gabriela",
//                        origin: Character.Location(name: "Gabriela", url: "Gabriela"),
//                        location: Character.Location(name: "Gabriela", url: "Gabriela"),
//                        image: "Gabriela",
//                        episode: ["Gabriela"],
//                        url: "Gabriela",
//                        created: "Gabriela"
//                    )
//                )
//            )
//        }
//        .frame(width: 300, height: 300)
//    }
//}
//#endif
