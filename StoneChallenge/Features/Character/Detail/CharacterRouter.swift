//
//  CharacterRouter.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 18/11/22.
//

import Foundation
import UIKit

class CharacterRouter {

    let viewControllerFactory: UserDependencyContainer
    let navigationController: UINavigationController

     init(viewControllerFactory: UserDependencyContainer) {
        self.viewControllerFactory = viewControllerFactory
        self.navigationController = viewControllerFactory.navigationController
    }
}
