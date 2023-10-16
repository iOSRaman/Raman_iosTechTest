//
//  DataListStruct.swift
//  Raman_iOSTechTest
//
//  Created by Genie Talk on 13/10/23.
//

import Foundation
struct DataListStruct: Codable {
    var breeds: [Breed]?
    var id: String?
    var url: String?
    var width, height: Int?
}
