//
//  TFTServices.swift
//  loltactics
//
//  Created by Ryan Nguyen on 9/25/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import Foundation

struct TFTServices {
    
    static let shared = TFTServices()
    let urlSession = URLSession(configuration: .default)
    
    func getItems(_ completion: @escaping(Result<[BuildsFrom]>) -> ()) {
        do {
            let request = try NetworkRequest.configureHTTPRequest(from: .itemList, with: nil)
            
            urlSession.dataTask(with: request) { (data, res, err) in
                
                if let response = res as? HTTPURLResponse, let unwrappedData = data {
                    
                    let result = NetworkResponse.handleNetworkResponse(for: response)
                    switch result {
                    case .success:
                        let result = try? JSONDecoder().decode(Item.self, from: unwrappedData)
                        guard let items = result?.buildsFrom else { return }
                        DispatchQueue.main.async {
                            completion(Result.success(items))
                        }
                    case .failure:
                        DispatchQueue.main.async {
                            completion(Result.failure(NetworkError.decodingFailed))
                        }
                    }
                }
            }.resume()
            
        } catch {
            completion(Result.failure(NetworkError.badRequest))
        }
        
    }
}
