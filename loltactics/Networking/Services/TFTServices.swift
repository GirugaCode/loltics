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
    
//    func downloadAllChamps() {
//        let url = URL(string: "https://solomid-resources.s3.amazonaws.com/blitz/tft/data/champions.json")!
//
//        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
//            guard let data = data else { return }
//
//            print(String(data: data, encoding: .utf8)!)
//            do {
//                let myStruct = try JSONDecoder().decode(newChampion.self, from: data)
//                print(myStruct)
//                DispatchQueue.main.async {
//                    self.allChampsArray = myStruct
//                    print("All champs array count", self.allChampsArray.count)
//                    self.tableView.reloadData()
//                }
//            } catch {
//                print("Didn't work")
//                return
//            }
//
//        }
//
//        task.resume()
//    }
    
    func getChamps(_ completion: @escaping(Result<[ChampionData]>) -> ()) {
        do {
            let request = try NetworkRequest.configureHTTPRequest(from: .championList, with: nil)
            
            urlSession.dataTask(with: request) { (data, res, err) in
                
                if let response = res as? HTTPURLResponse, let unwrappedData = data {
                    
                    let result = NetworkResponse.handleNetworkResponse(for: response)
                    switch result {
                    case .success:
                        let result = try? JSONDecoder().decode(newChampion.self, from: unwrappedData)
                        guard let champs = result else { return }
                        DispatchQueue.main.async {
                            var allChampsArray: [ChampionData] = []
                            let sortedKeys = champs.keys.sorted(by: >)
                            
                            for key in sortedKeys {
                                if let obj = champs[key] {
                                    allChampsArray.insert(obj, at: 0)
                                }
                            }
                            completion(Result.success(allChampsArray))
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
    
    func getChampsClass(_ completion: @escaping(Result<ChampClass>) -> ()) {
        do {
            let request = try NetworkRequest.configureHTTPRequest(from: .championClass, with: nil)
            
            urlSession.dataTask(with: request) { (data, res, err) in
                
                if let response = res as? HTTPURLResponse, let unwrappedData = data {
                    
                    let result = NetworkResponse.handleNetworkResponse(for: response)
                    switch result {
                    case .success:
                        let result = try? JSONDecoder().decode(ChampClass.self, from: unwrappedData)
                        guard let champClass = result else { return }
                        DispatchQueue.main.async {
                            completion(Result.success(champClass))
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
    
    func getItems(_ completion: @escaping(Result<Item>) -> ()) {
        do {
            let request = try NetworkRequest.configureHTTPRequest(from: .itemList, with: nil)
            
            let task = urlSession.dataTask(with: request) { (data, res, err) in
                
                if let response = res as? HTTPURLResponse, let unwrappedData = data {
                    
                    let result = NetworkResponse.handleNetworkResponse(for: response)
                    switch result {
                    case .success:
                        let result = try? JSONDecoder().decode(Item.self, from: unwrappedData)
                        guard let items = result else { return }
                        DispatchQueue.main.async {
                            completion(Result.success(items))
                        }
                    case .failure:
                        DispatchQueue.main.async {
                            completion(Result.failure(NetworkError.decodingFailed))
                        }
                    }
                }
            }
            task.resume()
            
        } catch {
            completion(Result.failure(NetworkError.badRequest))
        }
    }
}
