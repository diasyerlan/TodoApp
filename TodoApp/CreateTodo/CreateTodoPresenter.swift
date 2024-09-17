//
//  CreateTodoPresenter.swift
//  TodoApp
//
//  Created by Dias Yerlan on 14.09.2024.
//

import Foundation
import UIKit

protocol CreateTodoPresenter {
    var router: CreateTodoRouter? { get set }
    var interactor: CreateTodoInteractor? { get set }
    var view: CreateTodoView? { get set }
    
    func uploadTodoItem(text: String)
    func interactorDidUploadTodos(with result: Result<Void, Error>)
}

class CreateTodoPresenterImplementation: CreateTodoPresenter {
    var router: CreateTodoRouter?
    
    var interactor: CreateTodoInteractor?
    
    var view: CreateTodoView?
    
    func uploadTodoItem(text: String) {
        interactor?.uploadTodoItem(text: text)
    }
    
    func interactorDidUploadTodos(with result: Result<Void, Error>) {
        switch result {
        case .success():
            print("Todo upload succeeded")
            if let vc = view as? UIViewController {
                vc.dismiss(animated: true, completion: nil)
            }
        case .failure(let error):
            print(error)
        }
    }
    
    
}
