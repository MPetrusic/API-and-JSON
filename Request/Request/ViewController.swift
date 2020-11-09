//
//  ViewController.swift
//  Request
//
//  Created by Milos Petrusic on 09/11/2020.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400&formatted=0"
        getData(from: url)
    }
    
    private func getData(from url: String) {
        
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            
            var result: Response?
            
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            }
            catch {
                print("Failed")
            }
            guard let json = result else {
                return
            }
            print(json.results.sunset)
            print(json.results.sunrise)
            print(json.status)
            print(json.results.astronomical_twilight_begin)
        }.resume()
        
        
        
    }

}

struct Response: Codable {
    let results: MyResult
    let status: String
}

struct MyResult: Codable {
    let sunrise: String
    let sunset: String
    let solar_noon: String
    let day_length: Int
    let civil_twilight_begin: String
    let civil_twilight_end: String
    let nautical_twilight_begin: String
    let nautical_twilight_end: String
    let astronomical_twilight_begin: String
    let astronomical_twilight_end: String
}

