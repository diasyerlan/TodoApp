//
//  MainViewInteractor.swift
//  TodoApp
//
//  Created by Dias Yerlan on 31.08.2024.
//

import Foundation
import Firebase

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func getTodos()
    func updateItemStatus(todoId: String, isComplete: Bool)

}

enum FetchError: Error {
    case failed, noData, decodingFailed, networkError
}

class MainInteractor: AnyInteractor {
    
    var presenter: AnyPresenter?
    
    let DB_REF = Database.database().reference()
    
    var allItems = [TodoItem]()
    
    func getTodos() {
        DB_REF.child("items").queryOrdered(byChild: "isComplete").observe(.value) { [weak self] snapshot in
            guard let self = self else { return }

            // Clear the current items list
            self.allItems.removeAll()

            // Iterate over all child nodes and collect the todo items
            for childSnapshot in snapshot.children.allObjects as! [DataSnapshot] {
                guard let value = childSnapshot.value as? [String: Any] else {
                    print("No data found for childSnapshot")
                    continue
                }

                let id = childSnapshot.key
                let todoItem = TodoItem(keyID: id, dictionary: value)
                self.allItems.append(todoItem)
            }

            // Notify the presenter with the full list of items
            if self.allItems.isEmpty {
                self.presenter?.interactorDidFetchTodos(with: .failure(FetchError.noData))
            } else {
                self.presenter?.interactorDidFetchTodos(with: .success(self.allItems))
            }
        }
    }



    func updateItemStatus(todoId: String, isComplete: Bool) {
        let value = ["isComplete": isComplete]
        
        DB_REF.child("items").child(todoId).updateChildValues(value)
    }
    
}
