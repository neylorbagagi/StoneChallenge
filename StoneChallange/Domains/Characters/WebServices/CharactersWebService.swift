//
//  CharactersWebService.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 15/11/22.
//

import Foundation

class CharactersWebService: WebService<DataInfo<Character>> {

    func getCharacters(byPage id: Int, completion: @escaping (Result<DataInfo<Character>, Error>) -> Void) {

        var request = URLRequest.init(
            url: URL(string: "https://rickandmortyapi.com/api/character")!,
            cachePolicy: .returnCacheDataElseLoad,
            timeoutInterval: timeoutInterval)

        request.addValue(String(id), forHTTPHeaderField: "page")

        execute(request: request) { result in
            completion(result)
        }
    }
}
