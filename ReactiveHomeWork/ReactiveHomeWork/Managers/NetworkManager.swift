//
//  NetworkManager.swift
//  ReactiveHomeWork
//
//  Created by Александр Арсенюк on 12.11.2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
    
    func makeRequest(contentType: UserContentType,  complition: @escaping ([CellViewModel]?, String?) -> (Void) )
}

class NetworkManager: NetworkManagerProtocol {
    
    typealias JSON = [String: Any]
    
    private let baseURL = "https://swapi.co/api/"
    
    func makeRequest(contentType: UserContentType,  complition: @escaping ([CellViewModel]?, String?) -> (Void) ) {
        
        let requestURL: String = baseURL + contentType.rawValue + "/?format=json"
        
        guard let url = URL(string: requestURL) else { return }
        let urlRequest = URLRequest(url: url)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: urlRequest) { (data, responce, error) in
            if let error = error {
                complition(nil, error.localizedDescription)
                return
            }
            guard let data = data else { return }
            guard let fullJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? JSON else { return }
            guard let finalArray = fullJSON["results"] as? [JSON] else { return }
            var returnArray = [CellViewModel]()
            finalArray.map {
                var element: CellViewModel!
                switch contentType {
                    case .vehicles: element = self.decodeVehicleJSON(json: $0)
                    case .people: element = self.decodePeopleJSON(json: $0)
                    case .planets: element = self.decodePlanetJSON(json: $0)
                }
                returnArray.append(element)
            }
            complition(returnArray, nil)
        }
        task.resume()
    }
    
    private func decodeVehicleJSON(json: JSON) -> CellViewModel {
        
        let name = json["name"] as! String
        let model = json["model"] as! String
        let length = json["length"] as! String
        let vehicleClass = json["vehicle_class"] as! String
        let vehicleCellModel = CellViewModel(firstProperty: name, secondProperty: model, thirdProperty: length, fourthProperty: vehicleClass)
        return vehicleCellModel
    }
    
    private func decodePeopleJSON(json: JSON) -> CellViewModel {
        
        let name = json["name"] as! String
        let gender = json["gender"] as! String
        let height = json["height"] as! String
        let mass = json["mass"] as! String
        let peopleModel = CellViewModel(firstProperty: name, secondProperty: gender, thirdProperty: height, fourthProperty: mass)
        return peopleModel
    }
    
    private func decodePlanetJSON(json: JSON) -> CellViewModel {
        
        let name = json["name"] as! String
        let diameter = json["diameter"] as! String
        let gravity = json["gravity"] as! String
        let population = json["population"] as! String
        let planetModel = CellViewModel(firstProperty: name, secondProperty: diameter, thirdProperty: gravity, fourthProperty: population)
        return planetModel
    }
}
