//
//  MainViewInteractor.swift
//  TodoApp
//
//  Created by Dias Yerlan on 31.08.2024.
//

import Foundation

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func getTodos()
}

class MainInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getTodos() {
        
    }
    
    
}
