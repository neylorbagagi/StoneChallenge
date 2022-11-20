//
//  CharactersWebService.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 15/11/22.
//

import Foundation

class CharactersWebService: WebService<DataInfo<Character>> {
// TODO: corrigir erro que estoura ao pesquisar nome invalido
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

        guard var urlComponents = URLComponents(string: "https://rickandmortyapi.com/api/character") else { return }
        urlComponents.queryItems = params.map { URLQueryItem(name: $0.describe(), value: $0.getValue()) }

        // TODO: botar um erro aqui
        guard let url = urlComponents.url else { return }

        let request = URLRequest.init(
            url: url,
            cachePolicy: .returnCacheDataElseLoad,
            timeoutInterval: timeoutInterval)

        execute(request: request) { result in
            completion(result)
        }
    }
}
