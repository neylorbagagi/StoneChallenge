//
//  FilterViewControllerFactory.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 19/11/22.
//

import Foundation
import UIKit
import RxSwift

protocol FilterViewControllerFactoryProtocol {
    func filterViewControllerFactory(filterCallBack: PublishSubject<DataInfo<Character>>) -> UIViewController
}

extension UserDependencyContainer: FilterViewControllerFactoryProtocol {
    func filterViewControllerFactory(filterCallBack: PublishSubject<DataInfo<Character>>) -> UIViewController {

        let router = FilterRouter(viewControllerFactory: self)

        let interactor = FilterInteractor(webService: CharactersWebService())

        let presenter = FilterPresenter(
            interactor: interactor,
            router: router,
            filterCallBack: filterCallBack
        )

        return FilterViewController(viewModelProvider: presenter)
    }
}
