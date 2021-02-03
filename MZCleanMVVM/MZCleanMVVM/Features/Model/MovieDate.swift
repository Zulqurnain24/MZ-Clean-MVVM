//
//  MovieDate.swift
//  AssignmentApp
//
//  Created by Zulqurnain on 03/02/2021.
//  Copyright © 2021 Mohammad Zulqurnain. All rights reserved.
//

import Foundation


struct MovieDate : Codable {
    
    let max : String?
    let min : String?
    
    
    enum CodingKeys: String, CodingKey {
        case max = "max"
        case min = "min"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        max = try values.decodeIfPresent(String.self, forKey: .max)
        min = try values.decodeIfPresent(String.self, forKey: .min)
    }
    
}
