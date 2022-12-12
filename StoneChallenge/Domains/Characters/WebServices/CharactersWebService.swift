//
//  CharactersWebService.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 15/11/22.
//

import Foundation

protocol CharactersWebServiceType: AnyObject {
    var characterUrlString: String { get }

    func getCharacters(
        byPage urlString: String,
        completion: @escaping (Result<DataInfo<Character>, Error>
    ) -> Void)

    func getCharacters(
        parameters params: [APIParameter],
        completion: @escaping (Result<DataInfo<Character>, Error>
    ) -> Void)
}

public class CharactersWebService: WebService<DataInfo<Character>>, CharactersWebServiceType {

    public let characterUrlString = "https://rickandmortyapi.com/api/character"

    /// Get all characters, you can access the list of characters by using the /character endpoint.
    /// - Parameters:
    ///   - urlString: url to request
    ///   - completion: Result<DataInfo<Character>, Error>
    func getCharacters(byPage urlString: String,
                       completion: @escaping (Result<DataInfo<Character>, Error>) -> Void) {

        guard let url = URL(string: urlString) else { fatalError("Invalid Url") }

        let request = URLRequest.init(
            url: url,
            cachePolicy: .returnCacheDataElseLoad,
            timeoutInterval: timeoutInterval)

        execute(request: request) { result in
            completion(result)
        }
    }

    /// Filter characters
    /// - Parameters:
    ///   - params: [APIParameters]
    ///   - completion: Result<DataInfo<Character>, Error>
    func getCharacters(parameters params: [APIParameter],
                       completion: @escaping (Result<DataInfo<Character>, Error>) -> Void) {

        guard var urlComponents = URLComponents(string: characterUrlString) else {
            fatalError("Invalid Url")
        }

        urlComponents.queryItems = params.map { URLQueryItem(name: $0.describe(), value: $0.getValue()) }
        guard let url = urlComponents.url else {
            fatalError("Invalid Url composition")
        }

        let request = URLRequest.init(
            url: url,
            cachePolicy: .returnCacheDataElseLoad,
            timeoutInterval: timeoutInterval)

        execute(request: request) { result in
            completion(result)
        }
    }

    public override init() {}
}
