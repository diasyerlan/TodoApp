//
//  MainViewPresenter.swift
//  TodoApp
//
//  Created by Dias Yerlan on 31.08.2024.
//

import Foundation

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    func didTapCreateButton()
    func interactorDidFetchTodos(with result: Result<[TodoItem], Error>)
    func updateItemStatus(todoId: String, isComplete: Bool)
}

class MainPresenter: AnyPresenter {
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getTodos()
        }
    }
    
    var view: AnyView?
    
    func didTapCreateButton() {
        router?.navigateToCreateScreen(from: view!)
    }
    
    func interactorDidFetchTodos(with result: Result<[TodoItem], Error>) {
        switch result {
        case .success(let todos):
            print("Presenter received todos: \(todos)")
            view?.update(with: todos)
        case .failure(let error):
            print("Presenter encountered error: \(error)")
            view?.update(with: "Failed to fetch todos")
        }
    }
    
    func updateItemStatus(todoId: String, isComplete: Bool) {
        interactor?.updateItemStatus(todoId: todoId, isComplete: isComplete)
    }
    
    }
