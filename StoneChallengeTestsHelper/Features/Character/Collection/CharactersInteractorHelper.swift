//
//  CharactersInteractorHelper.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 23/11/22.
//

import Foundation
@testable import StoneChallenge

extension CharactersInteractor {
    public static func mock(
        webService: CharactersWebServiceType = CharactersWebServiceStub(),
        cache: ImageCacheProtocol = ImageCache()
    ) -> CharactersInteractor {
        .init(webService: webService, cache: cache)
    }
}
