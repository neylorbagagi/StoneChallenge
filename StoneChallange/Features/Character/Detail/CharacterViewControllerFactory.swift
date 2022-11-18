//
//  CharacterViewControllerFactory.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 18/11/22.
//

import Foundation
import UIKit

protocol CharacterViewControllerFactoryProtocol {
    func characterViewControllerFactory(character: Character) -> UIViewController
}

extension UserDependencyContainer: CharacterViewControllerFactoryProtocol {
    func characterViewControllerFactory(character: Character) -> UIViewController {

        let router = CharacterRouter(navigationController: navigationController)
        let interactor = CharacterInteractor(cache: imageCache)
        let presenter = CharacterPresenter(
            interactor: interactor,
            router: router,
            character: character
        )

        return CharacterViewController(viewModelProvider: presenter)
    }
}
