//
//  FilterViewControllerFactory.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 19/11/22.
//

import Foundation
import UIKit

protocol FilterViewControllerFactoryProtocol {
    func filterViewControllerFactory() -> UIViewController
}

extension UserDependencyContainer: FilterViewControllerFactoryProtocol {
    func filterViewControllerFactory() -> UIViewController {

        let router = FilterRouter(viewControllerFactory: self)

        let interactor = FilterInteractor()

        let presenter = FilterPresenter(
            interactor: interactor,
            router: router
        )

        return FilterViewController(viewModelProvider: presenter)
    }
}
