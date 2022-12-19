//
//  NetworkService.swift
//  Spacera
//
//  Created by Artem Bilyi on 10.12.2022.
//

import Foundation
import Alamofire

final class NetworkService {
    // MARK: - Decoder with convertFromSnakeCase
    private let decoder: JSONDecoder = {
        $0.keyDecodingStrategy = .convertFromSnakeCase
        return $0
    }(JSONDecoder())
    // MARK: - Rockets request
    func getRocketsInfo(completion: @escaping ([Rocket]) -> Void) {
        AF.request(GlobalLinks.spaceRockets).responseDecodable(of: [Rocket].self,
                                                               decoder: decoder) { response in
            switch response.result {
            case .success(let result):
                completion(result)
            case let .failure(error):
                print(error)
            }
        }
    }
    // MARK: - Launches request
    func getLaunchesInfo(completion: @escaping ([Launch]) -> Void) {
        AF.request(GlobalLinks.launches).responseDecodable(of: [Launch].self,
                                                           decoder: decoder) { response in
            switch response.result {
            case .success(let result):
                completion(result)
            case let .failure(error):
                print(error)
            }
        }
    }
}
