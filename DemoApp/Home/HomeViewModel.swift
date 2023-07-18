//
//  HomeViewModel.swift
//  DemoApp
//
//  Created by Satyendra Chauhan on 17/07/23.
//

import Foundation

protocol HomeViewModelType {
    var numberOfContacts: Int? { get }
    func contact(at index: Int) -> User?
    func getContacts(pageNumber: Int, handler: @escaping () -> Void)
}

extension HomeViewModelType {
    func getContacts(pageNumber: Int = 1, handler: @escaping () -> Void) {
        return getContacts(pageNumber: pageNumber, handler: handler)
    }
}

class HomeViewModel: HomeViewModelType {
    var numberOfContacts: Int? {
        return userList.count
    }
    var totalPages: Int {
        return userResponse?.totalPages ?? 0
    }
    var userResponse: UsersResponse?
    var userList: [User] = []
    let network = NetworkManager()
    func contact(at index: Int) -> User? {
        return userList[index]
    }
    
    func getContacts(pageNumber: Int, handler: @escaping () -> Void) {
        if (pageNumber <= totalPages) || pageNumber == 1 {
            network.request(urlString: .userList(pageNumber), method: .get) { [weak self] (result: Result<UsersResponse, NetworkError>) in
                switch result {
                case .success(let response):
                    self?.userResponse = response
                    self?.userList.append(contentsOf: response.data ?? [])
                    handler()
                case .failure(let failure):
                    debugPrint(failure.localizedDescription)
                }
            }
        }
    }
    
    
}
