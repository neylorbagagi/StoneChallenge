//
//  CharacterWebServiceHelper.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 24/11/22.
//

import Foundation
@testable import StoneChallenge

public class CharacterWebServiceStub: CharacterWebServiceType {

    var response: Result<Character, Error> = .success(Character.mock())

    public func getCharacter(
        byID id: Int,
        completion: @escaping (Result<Character, Error>) -> Void
    ) {
        completion(response)
    }

    public init() {}
}
