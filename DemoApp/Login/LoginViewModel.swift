//
//  LoginViewModel.swift
//  DemoApp
//
//  Created by Satyendra Chauhan on 17/07/23.
//

import Foundation

class LoginViewModel {
    // MARK: - variables
    let network: NetworkManager
    
    init(network: NetworkManager = NetworkManager()) {
        self.network = network
    }
    
    // MARK: - network call
    func login(username: String, password: String, handler: @escaping()->Void) {
        let loginRequest = LoginRequestModel(user_name: username, password: password)
        do {
            let body = try JSONEncoder().encode(loginRequest)
            network.request(urlString: .login, method: .post, parameter: body) {(result: Result<User, NetworkError>) in
                switch result {
                case .success( _):
                    handler()
                case .failure(_):
                    handler()
                }
            }
        } catch {
            // handle error
            handler()
        }
        
        
        
    }
}
