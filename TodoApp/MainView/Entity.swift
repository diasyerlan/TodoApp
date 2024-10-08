//
//  Entity.swift
//  TodoApp
//
//  Created by Dias Yerlan on 31.08.2024.
//

import Foundation

struct TodoItem: Codable {
    var title: String
    var isComplete: Bool
    var id: String
    
    init(keyID: String, dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.isComplete = dictionary["isComplete"] as? Bool ?? false
        self.id = keyID // Use the key from Firebase as the ID
    }
}
