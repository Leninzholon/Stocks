//
//  APIcaller.swift
//  Stocks
//
//  Created by apple on 13.12.2022.
//

import Foundation

final class APIcaller {
    static let shared = APIcaller()
    
    private init() {}
    
    //MARK: - Public
    
    //MARK: - Private
    
    private enum Endpoint: String {
        case search
    }
    private enum APIError: Error {
        case unownedError
        case invalidURL
    }
    private func url(for endpoint: Endpoint, queryParans: [String:String] = [:] ) -> URL? {
        
        return nil
    }
    private func request<T:Codable>(url: URL?, expecting: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = url else {
            completion(.failure(APIError.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                }
                else {
                    completion(.failure(APIError.unownedError))
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
