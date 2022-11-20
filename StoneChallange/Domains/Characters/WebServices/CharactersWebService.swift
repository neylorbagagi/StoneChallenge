//
//  CharactersWebService.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 15/11/22.
//

import Foundation

class CharactersWebService: WebService<DataInfo<Character>> {

    func getCharacters(byPage urlString: String, completion: @escaping (Result<DataInfo<Character>, Error>) -> Void) {

        let request = URLRequest.init(
            url: URL(string: urlString)!, // TODO: make it response erro instead of use !
            cachePolicy: .returnCacheDataElseLoad,
            timeoutInterval: timeoutInterval)

        execute(request: request) { result in
            completion(result)
        }
    }

    func getCharacters(parameters params: [APIParameters], completion: @escaping (Result<DataInfo<Character>, Error>) -> Void) {

        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
            return // TODO: botar um erro aqui
        }

        var request = URLRequest.init(
            url: url,
            cachePolicy: .returnCacheDataElseLoad,
            timeoutInterval: timeoutInterval)

        for param in params {
            request.addValue(param.describe(), forHTTPHeaderField: param.getValue())
        }

        execute(request: request) { result in
            completion(result)
        }
    }

    @available(*, deprecated, message: "Use getCharacters(byPage stringUrl: String, completion:)")
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
