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
}

enum FetchError: Error {
    case failed, noData, decodingFailed, networkError
}

class MainInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    let DB_REF = Database.database().reference()
    
    var allItems = [TodoItem]()
    
    func getTodos() {
        DB_REF.child("items").observe(.childAdded) { [weak self] snapshot in
            guard let value = snapshot.value else {
                print("No data found in snapshot")
                self?.presenter?.interactorDidFetchTodos(with: .failure(FetchError.noData))
                return
            }
            
            do {
                let todoDict = try JSONSerialization.data(withJSONObject: value)
                let todo = try JSONDecoder().decode(TodoItem.self, from: todoDict)
                self?.allItems.append(todo)
                self?.presenter?.interactorDidFetchTodos(with: .success(self?.allItems ?? []))
            } catch {
//                print("Failed to decode todo: \(error)")
                self?.presenter?.interactorDidFetchTodos(with: .failure(FetchError.decodingFailed))
            }
        }
    }
    
    
    

    
    
}
