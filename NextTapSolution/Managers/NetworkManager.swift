//
//  NetworkManager.swift
//  HMLET_Assignment
//
//  Created by Hyubyn on 3/21/20.
//  Copyright © 2020 Hyubyn. All rights reserved.
//

import Foundation

struct NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl = "https://api.steller.co/v1/"
    private let session = URLSession.shared
    
    private func sendRequest(urlRequest: URLRequest, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        session.dataTask(with: urlRequest) { (data, urlResponse, error) in
            if let urlResponse = urlResponse {
                print(urlResponse.description)
            }
            if let error = error {
                completionBlock(.failure(error))
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8) ?? "Request successful with result: nil")
                completionBlock(.success(data))
            }
        }.resume()
    }
    
    private func sendJsonResultRequest<T: Decodable>(urlRequest: URLRequest, result: @escaping (Result<T, Error>) -> Void) {
        sendRequest(urlRequest: urlRequest) { (response) in
            switch response {
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    result(.success(model))
                } catch let error {
                    print("Decode failed with error: \(error.localizedDescription)")
                    result(.failure(error))
                }
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}

//MARK: -
extension NetworkManager {
    func getStories(userId: String = "76794126980351029", result: @escaping (Result<NTFeedResponse,Error>) -> Void) {
        let urlString = baseUrl + "users/\(userId)/stories"
        let urlRequest = URLRequest(url: URL(string: urlString)!)
        sendJsonResultRequest(urlRequest: urlRequest, result: result)
    }
}
