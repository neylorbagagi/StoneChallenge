//
//  CharactersFactory.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 15/11/22.
//

import Foundation
import UIKit

protocol CharactersFactoryProtocol {
    func charactersFactory(characterList: [Character]) -> UIViewController
}

extension UserDependencyContainer: CharactersFactoryProtocol {
    func charactersFactory(characterList: [Character]) -> UIViewController {

        let router = CharactersRouter(navigationController: navigationController)
        let interactor = CharactersInteractor(webService: CharactersWebService())
        let presenter = CharactersPresenter(
            interactor: interactor,
            router: router,
            characterList: characterList
        )

        return CharactersViewController(viewModelProvider: presenter)
    }
}
