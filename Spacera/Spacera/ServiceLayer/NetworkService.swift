//
//  NetworkService.swift
//  Spacera
//
//  Created by Artem Bilyi on 30.12.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case networkError(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response"
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}

typealias RocketResult = Result<[Rocket]?, NetworkError>

protocol NetworkServiceProtocol {
    func getRockets(completion: @escaping (RocketResult) -> Void)
}

struct NetworkService: NetworkServiceProtocol {
    // MARK: - Rockets request
    func getRockets(completion: @escaping (RocketResult) -> Void) {
        guard let apiURL = URL(string: Links.rockets.rawValue) else {
            completion(.failure(.invalidURL))
            return
        }
        let request = URLRequest(url: apiURL)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode([Rocket].self, from: data)
//                DispatchQueue.main.async {
                    completion(.success(result))
//                }
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }
}
//        AF.request(Links.rockets.rawValue).responseDecodable(of: [Rocket].self,
//                                                             decoder: decoder) { response in
//            switch response.result {
//            case .success(let result):
//                completion(result)
//            case let .failure(error):
//                print(error)
//            }
//        }
// MARK: - Launches request
//    func getLaunchesInfo(completion: @escaping ([Launch]) -> Void) {
//        AF.request(GlobalLinks.launches).responseDecodable(of: [Launch].self,
//                                                           decoder: decoder) { response in
//            switch response.result {
//            case .success(let result):
//                completion(result)
//            case let .failure(error):
//                print(error)
//            }
//        }
//    }

/*
 guard let apiURL = URL(string: "\(Constants.mainURL)genre/\(mediaType)/list?api_key=\(Constants.apiKey)&language=en-US") else {
 fatalError("Invalid URL")
 }
 let session = URLSession(configuration: .default)
 let task = session.dataTask(with: apiURL) { data, response, error in
 guard let data = data else { return }
 do {
 let decoder = JSONDecoder()
 decoder.keyDecodingStrategy = .convertFromSnakeCase
 let response = try decoder.decode(GenresResponse.self, from: data)
 DispatchQueue.main.async {
 completion(response.genres!)
 }
 } catch {
 print("Error: \(error)")
 }
 }
 task.resume()
 }
 */
