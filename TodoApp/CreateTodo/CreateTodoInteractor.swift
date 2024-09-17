//
//  CreateTodoInteractor.swift
//  TodoApp
//
//  Created by Dias Yerlan on 14.09.2024.
//

import Foundation
import Firebase

protocol CreateTodoInteractor {
    var presenter: CreateTodoPresenter? { get set }
    
    func uploadTodoItem(text: String)
}

class CreateTodoInteractorImplementation: CreateTodoInteractor {
    var presenter: CreateTodoPresenter?
        
    let DB_REF = Database.database().reference()
    
    func uploadTodoItem(text: String) {
        let values = ["title": text, "isComplete": false] as [String: Any]
        let id = DB_REF.child("items").childByAutoId()
        id.updateChildValues(values) { err, _ in
            let value = ["id": id.key!]
            self.DB_REF.child("items").child(id.key!).updateChildValues(value) { error, _ in
                if let error = error {
                    self.presenter?.interactorDidUploadTodos(with: .failure(error))
                } else {
                    self.presenter?.interactorDidUploadTodos(with: .success(()))
                }
            }
        }
    }
}
