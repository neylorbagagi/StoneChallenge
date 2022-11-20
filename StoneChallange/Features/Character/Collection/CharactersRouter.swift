//
//  CharactersRouter.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 15/11/22.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

// TODO: CREATE A ROUTER PROTOCOL with navigationController

class CharactersRouter {

    let disposeBag = DisposeBag()

    public let showDetail = PublishRelay<Character>()
    public let showFilter = PublishRelay<Void>()

    let viewControllerFactory: UserDependencyContainer
    let navigationController: UINavigationController

     init(viewControllerFactory: UserDependencyContainer) {
        self.viewControllerFactory = viewControllerFactory
        self.navigationController = viewControllerFactory.navigationController
        bind()
    }

    private func bind() {
        showDetail
            .subscribe { [self] character in
                showDetail(character: character)
            }.disposed(by: disposeBag)

        showFilter
            .subscribe { [self] _ in
                showFilter(as: "asa") // TODO: corrigir isso
            }.disposed(by: disposeBag)
    }

    func showDetail(character: Character) {
        let viewController = viewControllerFactory.characterViewControllerFactory(character: character)
        navigationController.pushViewController(viewController, animated: true)
    }

    func showFilter(as: String) {
        let viewController = viewControllerFactory.filterViewControllerFactory()
        navigationController.pushViewController(viewController, animated: true)
    }
}
