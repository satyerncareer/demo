//
//  LoginRequestModel.swift
//  DemoApp
//
//  Created by Satyendra Chauhan on 17/07/23.
//

import Foundation

struct LoginRequestModel: Encodable {
    var user_name: String?
    var password: String?
}
