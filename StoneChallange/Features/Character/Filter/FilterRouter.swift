//
//  FilterRouter.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 19/11/22.
//

import Foundation
import UIKit
import RxRelay
import RxSwift

class FilterRouter {

    let disposeBag = DisposeBag()

    let pop = PublishRelay<Void>()

    let viewControllerFactory: UserDependencyContainer
    let navigationController: UINavigationController

     init(viewControllerFactory: UserDependencyContainer) {
        self.viewControllerFactory = viewControllerFactory
        self.navigationController = viewControllerFactory.navigationController
        bind()
    }

    // MARK - BIND
    private func bind() {
        pop.subscribe { [self] _ in // TODO: put it on a superclass
            navigationController.popViewController(animated: true)
        }.disposed(by: disposeBag)
    }
}
