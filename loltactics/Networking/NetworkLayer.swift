//
//  NetworkLayer.swift
//  loltactics
//
//  Created by Ryan Nguyen on 9/24/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import Foundation

class NetworkLayer {
    
    let urlSession = URLSession.shared
    var baseURL = "https://solomid-resources.s3.amazonaws.com/blitz/tft/data/items.json"
    
    
    func getHeaders() -> [String: String] {
        return [
            "Accept": "application/json",
            "Content-Type": "application/json",
            //            "nToken": "\()"
            //            "Host": "https://recominder-api.herokuapp.com/api/auth"
        ]
    }
    
    
    private func makeGetRequest() -> URLRequest {
        let fullURL = URL(string: baseURL)!
        var request = URLRequest(url: fullURL)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = getHeaders()
        
        return request
    }
    
    enum Result<T> {
          case success(T)
          case failedDecode(Error)
          case failure(Error)
      }
      
      enum EndPointError: Error {
          case couldNotParse
          case noData
      }
      
    
    func getItems(_ completion: @escaping (Result<Item>) -> Void) {
        let postsRequest = makeGetRequest()
        let task = urlSession.dataTask(with: postsRequest) { data, response, error in
            // Check for errors.
            if let error = error {
                return completion(Result.failure(error))
            }
            
            // Check to see if there is any data that was retrieved.
            guard let data = data else {
                return completion(Result.failure(EndPointError.noData))
            }
            
//            // Attempt to decode the data.
//            guard let result = try? JSONDecoder().decode(Item.self, from: data) else {
//                return completion(Result.failure(EndPointError.couldNotParse))
//            }
//
//            let item = try? JSONDecoder().decode(Item.self, from: data)
            //            print(result)
            //            let posts = result.posts
            
            // Return the result with the completion handler.
//            DispatchQueue.main.async {
//                completion(Result.success(item))
//            }
            
            do {
//                _ = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                //Updating UI keep on main thread!
                DispatchQueue.main.async {
                    let item = try! JSONDecoder().decode(Item.self, from: data)
//                    let swell = swZZells.first
                    completion(Result.success(item))
                    
                }
            } catch {
                print("Error decoding swell model!")
                completion(Result.failedDecode(error))
            }
        }
        
        task.resume()
    }
}
