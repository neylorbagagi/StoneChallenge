//
//  CharacterWebService.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 14/11/22.
//

import Foundation

protocol CharacterWebServiceType: AnyObject {
    func getCharacter(
        byID id: Int,
        completion: @escaping (Result<Character, Error>) -> Void
    )
}

class CharacterWebService: WebService<Character>, CharacterWebServiceType {

    func getCharacter(byID id: Int, completion: @escaping (Result<Character, Error>) -> Void) {

        guard let url = URL(string: "https://rickandmortyapi.com/api/character/\(id)") else {
            fatalError("Invalid Url")
        }

        let request = URLRequest.init(
            url: url,
            cachePolicy: .returnCacheDataElseLoad,
            timeoutInterval: timeoutInterval)

        execute(request: request) { result in
            completion(result)
        }
    }
}
