//
//  LaunchesModels.swift
//  Spacera
//
//  Created by Artem Bilyi on 09.12.2022.
//
import Foundation
// MARK: - LaunchesModels
struct Launch: Decodable {
    let rocket: String?
    let name: String?
    let success: Bool?
    let date_local: String?
    let net: Bool?
    let window: Int?
    let id: String?
}
