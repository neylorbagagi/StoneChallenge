//
//  CharacterWebService.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 14/11/22.
//

import Foundation

#warning ("Add RxSwift to this process")

class CharacterWebService: WebService<Character> {

    func getCharacter(byID id: Int, completion: @escaping (Result<Character, Error>) -> Void) {

        let request = URLRequest.init(
            url: URL(string: "https://rickandmortyapi.com/api/character/\(id)")!,
            cachePolicy: .returnCacheDataElseLoad,
            timeoutInterval: timeoutInterval)

        execute(request: request) { result in
            completion(result)
        }
    }
}
