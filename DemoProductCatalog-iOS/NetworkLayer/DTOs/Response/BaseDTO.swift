//
//  BaseDTO.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 10/07/2021.
//

import Foundation

struct BaseDTO<Body: DTO>: DTO {
    var status: Int
    var message: String
    var body: Body
    // Information regarding these keys are unavailable in the project documentation, hence safely ignoring.
    /*
     var exception: SomeExceptionDTO
     var update_available: Int
    */
}
