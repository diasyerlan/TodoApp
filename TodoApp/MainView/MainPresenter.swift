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
    
    func interactorDidFetchTodos(with result: Result<[Todo], Error>)
}

class MainPresenter: AnyPresenter {
    var router: AnyRouter?
    
    var interactor: AnyInteractor?
    
    var view: AnyView?
    
    func interactorDidFetchTodos(with result: Result<[Todo], Error>) {
        
    }
    
    
}
