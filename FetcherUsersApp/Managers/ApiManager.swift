//
//  ApiManager.swift
//  FetcherUsersApp
//
//  Created by Арсений Варицкий on 19.09.24.
//

import Foundation

class ApiManager {
    static let shared = ApiManager()
    
    private init() {}
    
    func fetchTodoItems(userId: Int? = nil, completion: @escaping (Result<[TodoModel], Error>) -> Void) {
        var urlString = "https://jsonplaceholder.typicode.com/todos"
        if let userId = userId {
            urlString += "?userId=\(userId)"
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let todoItems = try JSONDecoder().decode([TodoModel].self, from: data)
                completion(.success(todoItems))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
}
