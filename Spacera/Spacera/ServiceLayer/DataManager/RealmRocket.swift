//
//  RealmRocket.swift
//  Spacera
//
//  Created by Artem Bilyi on 03.01.2023.
//

import Foundation
import RealmSwift

class RocketRealm: Object {
    @Persisted(primaryKey: true) var id: String = ""
    @Persisted var height: Diameter?
    @Persisted var diameter: Diameter?
    @Persisted var mass: Mass?
    @Persisted var firstStage: FirstStage?
    @Persisted var secondStage: SecondStage?
    let payloadWeights = List<PayloadWeight>()
    let flickrImages = List<String>()
    @Persisted var name: String?
    @Persisted var costPerLaunch: Int?
    @Persisted var firstFlight: String?
    @Persisted var country: String?
}

extension RocketRealm {
    class Diameter: Object {
        @Persisted var meters: Double?
        @Persisted var feet: Double?
    }
}

extension RocketRealm {
    class FirstStage: Object {
        @Persisted var engines: Int?
        @Persisted var fuelAmountTons: Double?
        @Persisted var burnTimeSec: Int?
    }
}

extension RocketRealm {
    class Mass: Object {
        @Persisted var kg: Int?
        @Persisted var lb: Int?
    }
}
 
extension RocketRealm {
    // MARK: - PayloadWeight
    class PayloadWeight: Object {
        @Persisted var id: String?
        @Persisted var name: String?
        @Persisted var kg: Int?
        @Persisted var lb: Int?
    }
}

extension RocketRealm {
    class SecondStage: Object {
        @Persisted var engines: Int?
        @Persisted var fuelAmountTons: Double?
        @Persisted var burnTimeSec: Int?

    }
}

