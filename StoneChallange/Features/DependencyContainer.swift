//
//  DependencyContainer.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 15/11/22.
//

import Foundation
import UIKit

class UserDependencyContainer {
    var navigationController = UINavigationController()
    static var shared = UserDependencyContainer()
}
