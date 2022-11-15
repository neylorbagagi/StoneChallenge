//
//  WebServiceType.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 14/11/22.
//

import Foundation

protocol WebServiceType {
    associatedtype Element: Codable
    func execute(request: URLRequest, completion: @escaping (Result<Element, Error>) -> Void)
}

class WebService<Element: Codable>: WebServiceType {

    let timeoutInterval: TimeInterval = 20

    func execute(request: URLRequest, completion: @escaping (Result<Element, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard
                error == nil,
                let data = data
            else {
                completion(.failure(error!))
                return
            }

            do {
                let object = try JSONDecoder().decode(Element.self, from: data)
                completion(.success(object))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
