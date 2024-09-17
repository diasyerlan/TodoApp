//
//  CreateTodoRouter.swift
//  TodoApp
//
//  Created by Dias Yerlan on 14.09.2024.
//

import UIKit

protocol CreateTodoRouter {
    static func createModule() -> UIViewController
}

class CreateTodoRouterImplementation: CreateTodoRouter {
    
    static func createModule() -> UIViewController {
        let router = CreateTodoRouterImplementation()
        
        // Initialize the view, presenter, and interactor
        let view = CreateTodoViewController() // This is the UIViewController instance
        var presenter: CreateTodoPresenter = CreateTodoPresenterImplementation()
        var interactor: CreateTodoInteractor = CreateTodoInteractorImplementation()
        
        // Set up the VIPER module
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        return view
    }
}
