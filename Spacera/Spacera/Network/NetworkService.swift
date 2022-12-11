//
//  NetworkService.swift
//  Spacera
//
//  Created by Artem Bilyi on 10.12.2022.
//

import Foundation
import Alamofire

final class NetworkService {
    func getRocketsInfo(completion: @escaping ([Rocket]) -> Void) {
        AF.request(GlobalLinks.spaceRockets).responseDecodable(of: [Rocket].self) { response in
            switch response.result {
            case .success(let result):
                completion(result)
            case let .failure(error):
                print(error)
            }
        }
    }
    func getLaunchesInfo(completion: @escaping ([Launch]) -> Void) {
        AF.request(GlobalLinks.launches).responseDecodable(of: [Launch].self) { response in
            switch response.result {
            case .success(let result):
                completion(result)
            case let .failure(error):
                print(error)
            }
        }
    }
}
