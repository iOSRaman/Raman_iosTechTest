//
//  DetailsDataStruct.swift
//  Raman_iOSTechTest
//
//  Created by Genie Talk on 13/10/23.
//

import Foundation
struct DetailsDataStruct: Codable {
    var id: String?
    var url: String?
    var breeds: [Breed]?
    var width, height: Int?
}

struct Breed: Codable {
    var weight: Weight?
    var id, name: String?
    var cfaURL: String?
    var vetstreetURL: String?
    var vcahospitalsURL: String?
    var temperament, origin, countryCodes, countryCode: String?
    var description, lifeSpan: String?
    var indoor, lap: Int?
    var altNames: String?
    var adaptability, affectionLevel, childFriendly, dogFriendly: Int?
    var energyLevel, grooming, healthIssues, intelligence: Int?
    var sheddingLevel, socialNeeds, strangerFriendly, vocalisation: Int?
    var experimental, hairless, natural, rare: Int?
    var rex, suppressedTail, shortLegs: Int?
    var wikipediaURL: String?
    var hypoallergenic: Int?
    var referenceImageID: String?

    enum CodingKeys: String, CodingKey {
        case weight, id, name
        case cfaURL = "cfa_url"
        case vetstreetURL = "vetstreet_url"
        case vcahospitalsURL = "vcahospitals_url"
        case temperament, origin
        case countryCodes = "country_codes"
        case countryCode = "country_code"
        case description
        case lifeSpan = "life_span"
        case indoor, lap
        case altNames = "alt_names"
        case adaptability
        case affectionLevel = "affection_level"
        case childFriendly = "child_friendly"
        case dogFriendly = "dog_friendly"
        case energyLevel = "energy_level"
        case grooming
        case healthIssues = "health_issues"
        case intelligence
        case sheddingLevel = "shedding_level"
        case socialNeeds = "social_needs"
        case strangerFriendly = "stranger_friendly"
        case vocalisation, experimental, hairless, natural, rare, rex
        case suppressedTail = "suppressed_tail"
        case shortLegs = "short_legs"
        case wikipediaURL = "wikipedia_url"
        case hypoallergenic
        case referenceImageID = "reference_image_id"
    }
}

struct Weight: Codable {
    var imperial, metric: String?
}
