//
//  File.swift
//  Yelp-App
//
//  Created by Francisco Lira on 10/08/22
//  Copyright © 2022 Francisco. All rights reserved.
//

import Foundation


struct API {
    

    static func getRestaurants(completion: @escaping ([Restaurant]?) -> Void) {
        
        // ––––– TODO: Add your own API key!
        let apikey = "mZ554GOHt5Gp-ePBn4UPRsVylVCw9EjW7TFdmS89srKzPyEGDdsOhuAYZHgHmJYrMtuCbh7l8Vsquiiz7-4vZROAIKbcaIr6K3j6vv0GYbw2IOtDjryMr4baHSxCY3Yx"
        
        // Coordinates for San Francisco
        let lat = 37.773972
        let long = -122.431297
        
        
        let url = URL(string: "https://api.yelp.com/v3/transactions/delivery/search?latitude=\(lat)&longitude=\(long)")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                
                // ––––– TODO: Get data from API and return it using completion
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                                
                let restDictionaries = dataDictionary["businesses"] as! [[String: Any]]
                
                let restaurants = restDictionaries.map({ Restaurant.init(dict: $0) })
                
                // Using For Loop
//                var restaurants: [Restaurant] = []
//                for dictionary in restDictionaries {
//                    let restaurant = Restaurant.init(dict: dictionary)
//                    restaurants.append(restaurant)
//                }

                                
                return completion(restaurants)
                
                }
            }
        
            task.resume()
        
        }
    
    

    
}

    
