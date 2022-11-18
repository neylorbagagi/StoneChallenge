//
//  CharacterViewController.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 18/11/22.
//

import UIKit
import RxSwift

class CharacterViewController: UIViewController {

    let disposeBag = DisposeBag()

    // MARK: - VIEWS
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var textView: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Courier", size: 18)
        textView.text = viewModel.description
        return textView
    }()

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
    }

    // MARK: - PRIVATE FUNCTIONS
    private func configure() {
        view.backgroundColor = viewModel.backgroundColor
        title = viewModel.title

        view.addSubview(imageView)
        view.addSubview(textView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
                    router: CharacterRouter(navigationController: UINavigationController()),
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
