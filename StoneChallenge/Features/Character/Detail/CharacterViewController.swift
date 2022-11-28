//
//  CharacterViewController.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 18/11/22.
//

import UIKit
import RxSwift
import RxCocoa

class CharacterViewController: UIViewController {

    // MARK: - VIEWS
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var textView: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Courier", size: 18)
        textView.text = viewModel.description
        return textView
    }()

    private var stackView: UIStackView = .init()

    // MARK: - PRIVATE PROPERTIES
    private let disposeBag = DisposeBag()

    // MARK: - INJECTED PROPERTIES
    let viewModelProvider: CharacterViewModelProvider
    let viewModel: CharacterViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.viewDidLoad.accept(())
    }

    // MARK: - CONSTRUCTORS
    init(viewModelProvider: CharacterViewModelProvider) {
        self.viewModelProvider = viewModelProvider
        self.viewModel = viewModelProvider.viewModel
        super.init(nibName: nil, bundle: nil)

        bind()
        configure()
    }

    required init?(coder: NSCoder) { return nil }

    // MARK: - BIND
    func bind() {
        viewModel.image
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)

        // TODO: Have to kill this one
        NotificationCenter.default.rx
            .notification(UIDevice.orientationDidChangeNotification)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [self] _ in
                configureStackViewOrientation()
            }).disposed(by: disposeBag)
    }

    // MARK: - PRIVATE FUNCTIONS
    private func configureStackViewOrientation() {
        if UIDevice.current.orientation.isLandscape {
            stackView.axis = .horizontal
        } else {
            stackView.axis = .vertical
        }
    }

    private func configure() {
        view.backgroundColor = viewModel.backgroundColor
        title = viewModel.title

        stackView = UIStackView(
            arrangedSubviews: [
                imageView,
                textView
            ],
            axis: .vertical,
            spacing: 16
        )

        configureStackViewOrientation()

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 16
            ),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -16
            )
        ])
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct CharacterViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            CharacterViewController(
                viewModelProvider: CharacterPresenter(
                    interactor: CharacterInteractor(
                        cache: ImageCache()
                    ),
                    router: CharacterRouter(
                        viewControllerFactory: UserDependencyContainer()
                    ),
                    character: Character(
                        id: 2,
                        name: "Morty Smith",
                        status: "Alive",
                        species: "Human",
                        type: "",
                        gender: "Male",
                        origin: Character.Location(
                            name: "unknown",
                            url: ""
                        ),
                        location: Character.Location(
                            name: "Citadel of Ricks",
                            url: "https://rickandmortyapi.com/api/location/3"
                        ),
                        image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
                        episode: [
                            "https://rickandmortyapi.com/api/episode/1",
                            "https://rickandmortyapi.com/api/episode/2"
                        ],
                        url: "https://rickandmortyapi.com/api/character/2",
                        created: "2017-11-04T18:50:21.651Z"
                    )
                )
            )
        }
    }
}
#endif
