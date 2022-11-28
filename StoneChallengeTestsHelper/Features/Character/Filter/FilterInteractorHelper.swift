//
//  FilterInteractorHelper.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 28/11/22.
//

import Foundation
@testable import StoneChallenge

extension FilterInteractor {
    public static func mock(
        webService: CharactersWebServiceType = CharactersWebServiceStub()
    ) -> FilterInteractor {
        .init(webService: webService)
    }
}
