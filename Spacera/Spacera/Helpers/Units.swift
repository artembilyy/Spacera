//
//  Units.swift
//  Spacera
//
//  Created by Artem Bilyi on 18.12.2022.
//

import Foundation
// MARK: - NamesForCells
enum RocketViewText: String {
    case firstFlight    = "First flight"
    case country        = "Country"
    case costPerLaunch  = "Cost per launch"
    case engines        = "Engines count"
    case fuelAmountTons = "Fuel amount"
    case burnTimeSec    = "Burn time"
    case firstStage     = "FIRST STAGE"
    case secondStage    = "SECOND STAGE"
}
// MARK: - Sec Ton
enum UnitType: String {
    case ton = "ton"
    case sec = "sec"
}
// MARK: - Unit Types for segmented control
enum UnitTypes: String, CaseIterable {
    case height, diameter, weight, payload
    var description: [String] {
        switch self {
        case .height:   return ["m", "ft"]
        case .diameter: return ["m", "ft"]
        case .weight:   return ["kg", "lb"]
        case .payload:  return ["kg", "lb"]
        }
    }
}
