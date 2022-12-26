//
//  Units.swift
//  Spacera
//
//  Created by Artem Bilyi on 18.12.2022.
//

import Foundation
// MARK: - NamesForCells
enum RocketUnit: String {
    case height, diameter, weight, payload
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
    case m
    case ft
    case kg
    case lb
    case ton
    case sec
}
// MARK: - Unit Types for segmented control
enum UnitTypes: String, CaseIterable {
    case height, diameter, weight, payload
    var description: [String] {
        switch self {
        case .height:   return [UnitType.m.rawValue, UnitType.ft.rawValue]
        case .diameter: return [UnitType.m.rawValue, UnitType.ft.rawValue]
        case .weight:   return [UnitType.kg.rawValue, UnitType.lb.rawValue]
        case .payload:  return [UnitType.kg.rawValue, UnitType.lb.rawValue]
        }
    }
}
