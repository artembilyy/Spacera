//
//  RocketsViewModel.swift
//  Spacera
//
//  Created by Artem Bilyi on 11.12.2022.
//

import Foundation

enum Rockets: String {
    case height, diameter, weight, payload, firstFlight, country, costPerLaunch, firstStageEngines, firstStageFuelAmountTons, firstStageBurnTimeSEC, secondStageEngines, secondStageFuelAmountTons, secondStageBurnTimeSEC, id
}

final class RocketsViewModel {
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    private(set) var rockets: [Rocket] = []
    private(set) var rocketsData: [String: [String: [String]]] = [:]
    private(set) var rocketProperties: [String: [String]] = [:]
    private(set) var rocketName: [String] = []
    weak var delegate: ViewModelProtocol?
    func getRockets() {
        delegate?.showLoading()
        networkManager.getRocketsInfo { result in
            self.rockets = result
            self.delegate?.hideLoading()
            for rocket in self.rockets {
                guard let rocketName = rocket.name else { return }
                // id
                if let identifier = rocket.id {
                    self.rocketProperties.updateValue([identifier], forKey: Rockets.id.rawValue)
//                    print(identifier)
                }
                // section 1
                if let heightMeters = rocket.height?.meters,
                   let heightFeet = rocket.height?.feet,
                   let diameterMeters = rocket.diameter?.meters,
                   let diameterFeet = rocket.diameter?.feet,
                   let massKg = rocket.mass?.kg,
                   let massLb = rocket.mass?.lb,
                   let payloadKg = rocket.payload_weights?[0].kg,
                   let payloadLb = rocket.payload_weights?[0].lb {
                    self.rocketProperties.updateValue([String(heightMeters), String(heightFeet)],
                                               forKey: Rockets.height.rawValue)
                    self.rocketProperties.updateValue([String(diameterMeters), String(diameterFeet)],
                                               forKey: Rockets.diameter.rawValue)
                    self.rocketProperties.updateValue([String(massKg), String(massLb)],
                                               forKey: Rockets.weight.rawValue)
                    self.rocketProperties.updateValue([String(payloadKg), String(payloadLb)],
                                               forKey: Rockets.payload.rawValue)
                }
                // section 2
                if let firstFlight = rocket.first_flight,
                   let country = rocket.country,
                   let costPerLaunch = rocket.cost_per_launch {
                    self.rocketProperties.updateValue([String(firstFlight)],
                                               forKey: Rockets.firstFlight.rawValue)
                    self.rocketProperties.updateValue([String(country)],
                                               forKey: Rockets.country.rawValue)
                    self.rocketProperties.updateValue([String(costPerLaunch)],
                                               forKey: Rockets.costPerLaunch.rawValue)
                }
                // section 3
                if let firstStageEngines = rocket.first_stage?.engines,
                   let firstStageFuel = rocket.first_stage?.fuel_amount_tons,
                   let firstStageBurn = rocket.first_stage?.burn_time_sec {
                    self.rocketProperties.updateValue([String(firstStageEngines)],
                                                forKey: Rockets.firstStageEngines.rawValue)
                    self.rocketProperties.updateValue([String(firstStageFuel)],
                                                forKey: Rockets.firstStageFuelAmountTons.rawValue)
                    self.rocketProperties.updateValue([String(firstStageBurn)],
                                                forKey: Rockets.firstStageBurnTimeSEC.rawValue)
                }
                // section 4
                if let secondStageEngines = rocket.second_stage?.engines,
                   let secondStageFuel = rocket.second_stage?.fuel_amount_tons,
                    let secondStageBurn = rocket.second_stage?.burn_time_sec {
                    self.rocketProperties.updateValue([String(secondStageEngines)],
                                               forKey: Rockets.secondStageEngines.rawValue)
                    self.rocketProperties.updateValue([String(secondStageFuel)],
                                               forKey: Rockets.secondStageFuelAmountTons.rawValue)
                    self.rocketProperties.updateValue([String(secondStageBurn)],
                                               forKey: Rockets.secondStageBurnTimeSEC.rawValue)
                }
                self.rocketsData[rocketName] = self.rocketProperties
                self.rocketName.append(rocketName)
            }
            self.delegate?.updateView()
        }
    }
}
