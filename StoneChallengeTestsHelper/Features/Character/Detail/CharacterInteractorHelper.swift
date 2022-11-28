//
//  CharacterInteractorHelper.swift
//  StoneChallenge
//
//  Created by Neylor Bagagi on 25/11/22.
//

import Foundation
@testable import StoneChallenge

extension CharacterInteractor {
    public static func mock(
        cache: ImageCacheProtocol = ImageCacheStub()
    ) -> CharacterInteractor {
        .init(cache: cache)
    }
}
