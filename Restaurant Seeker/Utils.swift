//
//  Utils.swift
//  Restaurant Seeker
//
//  Created by Minnie on 11/17/20.
//

import Foundation

let SEARCH_URL = "https://api.yelp.com/v3/businesses/search?"

// main function for getting restaurants within certain radius
func getRestaurants(longitude: Float, latitude: Float, radius: Int, categories: String...) -> Array<Restaurant> {
//    var baseUrl = SEARCH_URL + ProcessInfo.processInfo.environment["YELP_API_KEY"]!
    var baseUrl = SEARCH_URL + "latitude=\(latitude)&longitude=\(longitude)&radius=\(radius)"
    var restaurants = [Restaurant]()
    if categories.count > 0 {
        baseUrl += "&categories="
        for category in categories {
            baseUrl += category + ","
        }
        baseUrl.remove(at: baseUrl.index(before: baseUrl.endIndex))
    }
    
    var request = URLRequest(url: URL(string: baseUrl)!)
    request.setValue("Bearer \(ProcessInfo.processInfo.environment["YELP_API_KEY"]!)", forHTTPHeaderField: "Authorization");
    request.httpMethod = "GET"
    
    // get request json
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            // error handling here
            print(error)
        }
        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: [])
            guard let resp = json as? NSDictionary else {return}
            guard let businesses = resp.value(forKey: "businesses") as? [NSDictionary] else {return}
            
            for business in businesses {
                var restaurant = Restaurant()
                restaurant.name = business.value(forKey: "name") as? String
                restaurant.id = business.value(forKey: "id") as? String
                restaurant.rating = business.value(forKey: "rating") as? Float
                restaurant.price = business.value(forKey: "price") as? String
                restaurant.is_closed = business.value(forKey: "is_closed") as? Bool
                restaurant.distance = business.value(forKey: "distance") as? Double
                let address = business.value(forKeyPath: "location.display_address") as? [String]
                restaurant.address = address?.joined(separator: "\n")
                
                restaurants.append(restaurant)
            }
        }
        catch {
            // error handle
            print("Caught error")
        }
    }.resume();
    
    return restaurants
}
