//
//  MainViewRouter.swift
//  TodoApp
//
//  Created by Dias Yerlan on 31.08.2024.
//

import Foundation
import UIKit

typealias EntryPoint = AnyView & UIViewController
protocol AnyRouter {
    var entry: EntryPoint? { get }
    static func start() -> AnyRouter
}

class UserRouter: AnyRouter {
    
    var entry: EntryPoint?
    static func start() -> AnyRouter {
        let router = UserRouter()
        
        var view: AnyView = MainViewController()
        var presenter: AnyPresenter = MainPresenter()
        var interactor: AnyInteractor = MainInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        return router
    }
    
    
}
