//
//  MainView.swift
//  TodoApp
//
//  Created by Dias Yerlan on 31.08.2024.
//

import Foundation
import UIKit

protocol AnyView {
    var presenter: AnyPresenter? { get set }
    
    func update(with todos: [TodoItem])
    func update(with error: String)
}

class MainViewController: UITableViewController, AnyView {
    var presenter: AnyPresenter?
    let reuserIdentifier = "TodoCell"
    var todoItems = [TodoItem]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var createNewButton: UIButton = {
        let button = UIButton()
        button.tintColor = .red
        button.backgroundColor = .green
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        
        button.addTarget(self, action: #selector(createNewTodo), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    func update(with todos: [TodoItem]) {
        self.todoItems = todos
    }
    
    func update(with error: String) {
        
    }
    
    // MARK: - Selectors
    
    @objc func createNewTodo() {
        presenter?.didTapCreateButton()
    }
    
    // MARK: - Helper Functions
    func configureTableView() {
        view.backgroundColor = .lightGray
        tableView.register(TodoCell.self, forCellReuseIdentifier: reuserIdentifier)
        tableView.rowHeight = 75
        tableView.separatorColor = .systemGray3
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.tableFooterView = UIView()
        
        tableView.addSubview(createNewButton)
        createNewButton.anchor(bottom: tableView.safeAreaLayoutGuide.bottomAnchor, right: tableView.safeAreaLayoutGuide.rightAnchor, paddingBottom: 16, paddingRight: 16, width: 56, height: 56)
        createNewButton.layer.cornerRadius = 56 / 2
        createNewButton.alpha = 1
    }
}

// MARK: - UITableViewDelegate/UITableViewDataSource

extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as? TodoCell else { return UITableViewCell() }
        cell.todoItem = todoItems[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todoItem = todoItems[indexPath.row]
        presenter?.updateItemStatus(todoId: todoItem.id, isComplete: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
