//
//  RocketsViewModel.swift
//  Spacera
//
//  Created by Artem Bilyi on 11.12.2022.
//

import Foundation

enum Rockets: String {
    case height, diameter, weight, payload,
         firstFlight, country, costPerLaunch,
         firstStageEngines, firstStageFuelAmountTons, firstStageBurnTimeSEC,
         secondStageEngines, secondStageFuelAmountTons, secondStageBurnTimeSEC,
         id, images
}

final class RocketViewModel {
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    private(set) var rocketsData: [String: [String: [String]]] = [:]
    private(set) var rocketProperties: [String: [String]] = [:]
    private(set) var rocketName: [String] = []
    private(set) var images: [String] = []
    weak var delegate: ViewModelProtocol?
    func fetchRockets() {
        delegate?.showLoading()
        networkManager.getRocketsInfo { result in
            self.delegate?.hideLoading()
            self.rocketProperties = [:]
            for rocket in result {
                guard let rocketName = rocket.name else { return }
                self.images = []
                for url in rocket.flickrImages ?? [] {
                    // add another logic
                    self.images.append(url)
                }
                self.rocketProperties.updateValue(self.images,
                                                  forKey: Rockets.images.rawValue)
                // section 1
                if let heightMeters = rocket.height?.meters,
                   let heightFeet = rocket.height?.feet,
                   let diameterMeters = rocket.diameter?.meters,
                   let diameterFeet = rocket.diameter?.feet,
                   let massKg = rocket.mass?.kg,
                   let massLb = rocket.mass?.lb,
                   let payloadKg = rocket.payloadWeights?[0].kg,
                   let payloadLb = rocket.payloadWeights?[0].lb {
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
                if let firstFlight = rocket.firstFlight,
                   let country = rocket.country,
                   let costPerLaunch = rocket.costPerLaunch {
                    self.rocketProperties.updateValue([String(firstFlight)],
                                                      forKey: Rockets.firstFlight.rawValue)
                    self.rocketProperties.updateValue([String(country)],
                                                      forKey: Rockets.country.rawValue)
                    self.rocketProperties.updateValue([String(costPerLaunch)],
                                                      forKey: Rockets.costPerLaunch.rawValue)
                }
                // section 3
                if let firstStageEngines = rocket.firstStage?.engines {
                    self.rocketProperties.updateValue([String(firstStageEngines)],
                                                      forKey: Rockets.firstStageEngines.rawValue)
                }
                if let firstStageFuel = rocket.firstStage?.fuelAmountTons {
                    self.rocketProperties.updateValue([String(firstStageFuel)],
                                                      forKey: Rockets.firstStageFuelAmountTons.rawValue)
                }
                if rocket.firstStage?.burnTimeSec == nil {
                    self.rocketProperties.updateValue([String("unknown")],
                                                      forKey: Rockets.firstStageBurnTimeSEC.rawValue)
                } else {
                    if let firstStageBurn = rocket.firstStage?.burnTimeSec {
                        self.rocketProperties.updateValue([String(firstStageBurn)],
                                                          forKey: Rockets.firstStageBurnTimeSEC.rawValue)
                    }
                }
                // section 4
                if let secondStageEngines = rocket.secondStage?.engines {
                    self.rocketProperties.updateValue([String(secondStageEngines)],
                                                      forKey: Rockets.secondStageEngines.rawValue)
                }
                if let secondStageFuel = rocket.secondStage?.fuelAmountTons {
                    self.rocketProperties.updateValue([String(secondStageFuel)],
                                                      forKey: Rockets.secondStageFuelAmountTons.rawValue)
                }
                if rocket.secondStage?.burnTimeSec == nil {
                    self.rocketProperties.updateValue(["unknown"],
                                                      forKey: Rockets.secondStageBurnTimeSEC.rawValue)
                } else {
                    if let secondStageBurn = rocket.secondStage?.burnTimeSec {
                        self.rocketProperties.updateValue([String(secondStageBurn)],
                                                          forKey: Rockets.secondStageBurnTimeSEC.rawValue)
                    }
                }
                self.rocketsData[rocketName] = self.rocketProperties
                self.rocketName.append(rocketName)
            }
            self.delegate?.updateView()
        }
    }
}
