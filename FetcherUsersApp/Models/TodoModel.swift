//
//  TodoModel.swift
//  FetcherUsersApp
//
//  Created by Арсений Варицкий on 19.09.24.
//

import Foundation

struct TodoModel: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
