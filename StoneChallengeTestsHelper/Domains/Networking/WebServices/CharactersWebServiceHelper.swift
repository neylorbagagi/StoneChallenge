//
//  CharactersWebServiceHelper.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 24/11/22.
//

import Foundation
@testable import StoneChallenge

class CharactersWebServiceStub: CharactersWebServiceType {

    var response: Result<DataInfo<Character>, Error> = .success(DataInfo<Character>.mock())

    var characterUrlString: String = ""

    func getCharacters(
        byPage urlString: String,
        completion: @escaping (Result<DataInfo<Character>, Error>
    ) -> Void) {
        completion(response)
    }

    func getCharacters(
        parameters params: [APIParameters],
        completion: @escaping (Result<DataInfo<Character>, Error>
    ) -> Void) {
        completion(response)
    }
}
