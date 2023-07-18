//
//  NetworkManager.swift
//  DemoApp
//
//  Created by Satyendra Chauhan on 17/07/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case invalidData
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    // Add more methods as needed
}

class NetworkManager {
    
    let baseUrl = "https://reqres.in/"
    
    func request<T: Decodable>(urlString: APIEndPoint.EndPoints, method: HTTPMethod, parameter: Data? = nil, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: urlString.endPoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if method == .post && parameter != nil {
            request.httpBody = parameter
        }
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            DispatchQueue.main.async {
                do {
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedObject))
                    self?.printResponse(data)
                } catch {
                    completion(.failure(.invalidData))
                }
            }
        }.resume()
    }
    
    func printResponse(_ data: Data) {
        #if DEBUG
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print("##################### Response #####################")
            print(String(decoding:  jsonData, as: UTF8.self))
        } else {
            print(" response json data malformed")
        }
        #endif
    }
}
