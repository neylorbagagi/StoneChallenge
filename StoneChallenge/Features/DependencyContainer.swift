//
//  DependencyContainer.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 15/11/22.
//

import Foundation
import UIKit

public class UserDependencyContainer {
    var navigationController = UINavigationController()
    let imageCache = ImageCache()
    static var shared = UserDependencyContainer()

    public init() {}
}
