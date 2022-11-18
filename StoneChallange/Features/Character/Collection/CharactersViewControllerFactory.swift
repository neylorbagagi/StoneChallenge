//
//  CharactersViewController.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 15/11/22.
//

import Foundation
import UIKit

protocol CharactersViewControllerFactoryProtocol {
    func charactersViewControllerFactory(characterList: [Character]) -> UIViewController
}

extension UserDependencyContainer: CharactersViewControllerFactoryProtocol {
    func charactersViewControllerFactory(characterList: [Character]) -> UIViewController {

        let router = CharactersRouter(viewControllerFactory: self)
        let interactor = CharactersInteractor(webService: CharactersWebService())
        let presenter = CharactersPresenter(
            interactor: interactor,
            router: router,
            characterList: characterList
        )

        return CharactersViewController(viewModelProvider: presenter)
    }
}
