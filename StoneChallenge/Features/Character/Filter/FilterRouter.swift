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

    // MARK: - SUBJECTS
    public let pop = PublishRelay<Void>()

    // MARK: - PRIVATE PROPERTIES
    private let disposeBag = DisposeBag()

    // MARK: - INJECTED PROPERTIES
    let viewControllerFactory: UserDependencyContainer
    let navigationController: UINavigationController

    // MARK: - CONSTRUCTORS
    init(viewControllerFactory: UserDependencyContainer) {
        self.viewControllerFactory = viewControllerFactory
        self.navigationController = viewControllerFactory.navigationController
        bind()
    }

    // MARK: - BIND
    private func bind() {
        pop
            .observe(on: MainScheduler.instance)
            .subscribe { [self] _ in
                navigationController.popViewController(animated: true)
        }.disposed(by: disposeBag)
    }
}
