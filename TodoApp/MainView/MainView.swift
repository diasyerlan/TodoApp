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
}

class MainViewController: UITableViewController, AnyView {
    var presenter: AnyPresenter?
    let reuserIdentifier = "TodoCell"
    
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
    
    // MARK: - Selectors
    
    @objc func createNewTodo() {
        let create = CreateTodoViewController()
        present(create, animated: true, completion: nil)
    }
    
    // MARK: - Helper Functions
    func configureTableView() {
        view.backgroundColor = .lightGray
        tableView.register(TodoCell.self, forCellReuseIdentifier: reuserIdentifier)
        tableView.rowHeight = 75
        tableView.separatorColor = .systemRed
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
        return 5
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as? TodoCell else { return UITableViewCell() }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
