//
//  HttpClient.swift
//  MyNewspaperApplication
//
//  Created by Nitin Prakash on 22/03/25.
//

import Foundation

enum ApiError: Error {
    case apiError(error: CustomError?)
}

struct CustomError: Error {
    let description: String
}

class NetworkManager {
    lazy var networkSession: URLSession = {
        let commonSessionConfiguration = URLSessionConfiguration.default
        commonSessionConfiguration.timeoutIntervalForRequest = 30.0
        commonSessionConfiguration.timeoutIntervalForResource = 30.0

        let session = URLSession(configuration: commonSessionConfiguration)
        return session
    }()
    
    private init() {}
    
    static let shared = NetworkManager()
    
    func dataTask<T: Decodable>(with request: URLRequest, completion: @escaping (Result<T, ApiError>) -> Void) {
        let task = networkSession.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.apiError(error: CustomError(description: error.localizedDescription))))
                    return
                }
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.apiError(error: CustomError(description: "data not received"))))
                }
                return
            }

            guard let object = try? JSONDecoder().decode(T.self, from: data) else {
                DispatchQueue.main.async {
                    completion(.failure(.apiError(error: CustomError(description: "data not parsed"))))
                }
                return
            }

            DispatchQueue.main.async {
                completion(.success(object))
            }
        }
        task.resume()
    }
}
