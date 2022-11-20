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
//    public let showFilter = PublishRelay<PublishSubject<DataInfo<Character>>>()

//    public let showFilter = PublishRelay<PublishSubject<(DataInfo<Character>, [APIParameters]?)>>()
    public let showFilter = PublishRelay<(callback: PublishSubject<FilterCallBack>,
                                          params: [APIParameters]?)>()

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
            .subscribe { [self] tuple in
                guard let (callback, params) = tuple.element else { return } // TODO: fazer do modo RX
                showFilter(using: callback, with: params)
            }.disposed(by: disposeBag)
    }

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
