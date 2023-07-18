//
//  APIEndPoints.swift
//  DemoApp
//
//  Created by Satyendra Chauhan on 17/07/23.
//

import Foundation

struct APIEndPoint {
    let baseUrl = "https://reqres.in/"
    enum EndPoints {
        case userList(Int)
        case register
        case login
        case addUser
        
        var endPoint: String {
            switch self {
            case .userList(let pageNumber):
                return "https://reqres.in/api/users?page=\(pageNumber)"
            case .register:
                return "https://reqres.in/api/register"
            case .login:
                return "https://reqres.in/api/login"
            case .addUser:
                return "https://reqres.in/api/users"
            }
        }
    }
}
