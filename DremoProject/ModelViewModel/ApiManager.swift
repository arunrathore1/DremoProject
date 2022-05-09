//
//  ApiManager.swift
//  DremoProject
//
//  Created by Arun Singh on 09/05/22.
//

import Foundation

class NetworkManager {
    static func getDataFromApi(completion: @escaping (Result<[Gorest], Error>) -> Void) {
        let url = URL(string: "https://gorest.co.in/public/v2/posts")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            
            print("Response status code: \(response.statusCode)")
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Gorest].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
}
