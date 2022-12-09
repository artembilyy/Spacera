//
//  RocketsModels.swift
//  Spacera
//
//  Created by Artem Bilyi on 09.12.2022.
//

import Foundation
// MARK: - RocketModel
struct Rocket {
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
    struct Diameter {
        let meters, feet: Double?
    }
}

extension Rocket {
    // MARK: - Engines
    struct Engines {
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
    struct ISP {
        let seaLevel, vacuum: Int?
    }
}

extension Rocket.Engines {
    // MARK: - Thrust
    struct Thrust {
        let kN, lbf: Int?
    }
}

extension Rocket {
    // MARK: - FirstStage
    struct FirstStage {
        let thrustSeaLevel, thrustVacuum: Rocket.Engines.Thrust?
        let reusable: Bool?
        let engines: Int?
        let fuelAmountTons: Double?
        let burnTimeSEC: Int?
    }
}

extension Rocket {
    // MARK: - LandingLegs
    struct LandingLegs {
        let number: Int?
        let material: String?
    }
}

extension Rocket {
    // MARK: - Mass
    struct Mass {
        let kg, lb: Int?
    }
}

extension Rocket {
    // MARK: - PayloadWeight
    struct PayloadWeight {
        let id, name: String?
        let kg, lb: Int?
    }
}

extension Rocket {
    // MARK: - SecondStage
    struct SecondStage {
        let thrust: Rocket.Engines.Thrust?
        let payloads: Payloads?
        let reusable: Bool?
        let engines: Int?
        let fuelAmountTons: Double?
        let burnTimeSEC: Int?
    }
}

extension Rocket {
    // MARK: - Payloads
    struct Payloads {
        let compositeFairing: CompositeFairing?
        let option1: String?
    }
}

extension Rocket.Payloads {
    // MARK: - CompositeFairing
    struct CompositeFairing {
        let height, diameter: Rocket.Diameter?
    }
}
