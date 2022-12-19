//
//  RocketsModels.swift
//  Spacera
//
//  Created by Artem Bilyi on 09.12.2022.
//

import Foundation
// MARK: - RocketModel
struct Rocket: Decodable {
    let height, diameter: Diameter?
    let mass: Mass?
    let firstStage: FirstStage?
    let secondStage: SecondStage?
    let engines: Engines?
    let landingLegs: LandingLegs?
    let payloadWeights: [PayloadWeight]?
    let flickrImages: [String]?
    let name, type: String?
    let active: Bool?
    let stages, boosters, costPerLaunch, successRatePct: Int?
    let firstFlight, country, company: String?
    let wikipedia: String?
    let welcomeDescription, id: String?
}

extension Rocket {
    // MARK: - Diameter
    struct Diameter: Decodable {
        let meters, feet: Double?
    }
}

extension Rocket {
    // MARK: - Engines
    struct Engines: Decodable {
        let isp: ISP?
        let thrustSeaLevel, thrustVacuum: Thrust?
        let number: Int?
        let type, version: String?
        let layout: String?
        let engineLossMax: Int?
        let propellant1, propellant2: String?
        let thrustToWeight: Double?
    }
}

extension Rocket.Engines {
    // MARK: - ISP
    struct ISP: Decodable {
        let seaLevel, vacuum: Int?
    }
}

extension Rocket.Engines {
    // MARK: - Thrust
    struct Thrust: Decodable {
        let kN, lbf: Int?
    }
}

extension Rocket {
    // MARK: - FirstStage
    struct FirstStage: Decodable {
        let thrustSeaLevel, thrustVacuum: Rocket.Engines.Thrust?
        let reusable: Bool?
        let engines: Int?
        let fuelAmountTons: Double?
        let burnTimeSec: Int?
    }
}

extension Rocket {
    // MARK: - LandingLegs
    struct LandingLegs: Decodable {
        let number: Int?
        let material: String?
    }
}

extension Rocket {
    // MARK: - Mass
    struct Mass: Decodable {
        let kg, lb: Int?
    }
}

extension Rocket {
    // MARK: - PayloadWeight
    struct PayloadWeight: Decodable {
        let id, name: String?
        let kg, lb: Int?
    }
}

extension Rocket {
    // MARK: - SecondStage
    struct SecondStage: Decodable {
        let thrust: Rocket.Engines.Thrust?
        let payloads: Payloads?
        let reusable: Bool?
        let engines: Int?
        let fuelAmountTons: Double?
        let burnTimeSec: Int?
    }
}

extension Rocket {
    // MARK: - Payloads
    struct Payloads: Decodable {
        let compositeFairing: CompositeFairing?
        let option1: String?
    }
}

extension Rocket.Payloads {
    // MARK: - CompositeFairing
    struct CompositeFairing: Decodable {
        let height, diameter: Rocket.Diameter?
    }
}
