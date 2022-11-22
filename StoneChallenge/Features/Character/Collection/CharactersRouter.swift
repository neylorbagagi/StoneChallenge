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

class CharactersRouter {

    // MARK: - SUBJECTES
    public let showDetail = PublishRelay<Character>()
    public let showFilter = PublishRelay<(callback: PublishSubject<FilterCallBack>,
                                          params: [APIParameters]?)>()

    // MARK: - PRIVATE PROPERTIES
    private let disposeBag = DisposeBag()

    // MARK: - INJECTED PROPERTIES
    let viewControllerFactory: UserDependencyContainer
    let navigationController: UINavigationController

    init(viewControllerFactory: UserDependencyContainer) {
        self.viewControllerFactory = viewControllerFactory
        self.navigationController = viewControllerFactory.navigationController

        bind()
    }

    // MARK: - BIND
    private func bind() {
        showDetail
            .subscribe { [self] character in
                showDetail(character: character)
            }.disposed(by: disposeBag)

        showFilter
            .subscribe(onNext: { [self] filter in
                showFilter(using: filter.callback, with: filter.params)
            }).disposed(by: disposeBag)
    }

    // MARK: - PRIVATE FUNCTIONS
    private func showDetail(character: Character) {
        let viewController = viewControllerFactory.characterViewControllerFactory(character: character)
        navigationController.pushViewController(viewController, animated: true)
    }

    private func showFilter(using callBack: PublishSubject<FilterCallBack>,
                            with parameters: [APIParameters]?) {
        let viewController = viewControllerFactory.filterViewControllerFactory(
            filterCallBack: callBack,
            filterParameters: parameters
        )
        navigationController.pushViewController(viewController, animated: true)
    }
}
