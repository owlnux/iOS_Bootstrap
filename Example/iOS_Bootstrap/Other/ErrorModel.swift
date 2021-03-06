//
//  ErrorModel.swift
//  iOS_Bootstrap_Example
//
//  Created by Ahmad Mahmoud on 9/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import iOS_Bootstrap

struct ErrorModel : StringConvertable {
    var statusCode : Int?
    var description : String?
    var response : URLResponse?
}
