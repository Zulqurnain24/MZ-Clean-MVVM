//
//  MZClientHTTPNetworking.swift
//  AssignmentApp
//
//  Created by Zulqurnain on 03/02/2021.
//  Copyright © 2021 Mohammad Zulqurnain. All rights reserved.
//

import Foundation

enum DataResponseError: Error {
    case network
    case decoding
    
    var reason: String {
        switch self {
        case .network:
            return "An error occurred while fetching data"
        case .decoding:
            return "An error occurred while decoding data"
        }
    }
}


extension HTTPURLResponse {
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= statusCode
    }
}

enum Result<T, U: Error> {
    case success(T)
    case failure(U)
}

protocol MZDataProvider {
    func fetchRemote<Model: Codable>(_ val: Model.Type, url: URL, completion: @escaping (Result<Codable, DataResponseError>) -> Void)
}

final class MZClientHTTPNetworking : MZDataProvider {
   
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchRemote<Model: Codable>(_ val: Model.Type, url: URL,
                         completion: @escaping (Result<Codable, DataResponseError>) -> Void) {
        let urlRequest = URLRequest(url: url)
        session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.hasSuccessStatusCode,
                let data = data
                else {
                    completion(Result.failure(DataResponseError.network))
                    return
            }
            guard let decodedResponse = try? JSONDecoder().decode(Model.self, from: data) else {
                completion(Result.failure(DataResponseError.decoding))
                return
            }
            completion(Result.success(decodedResponse))
        }).resume()
    }
}
