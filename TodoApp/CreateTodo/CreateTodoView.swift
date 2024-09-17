//
//  CreateTodoView.swift
//  TodoApp
//
//  Created by Dias Yerlan on 12.09.2024.
//

import Foundation
import UIKit

protocol CreateTodoView {
    var presenter: CreateTodoPresenter? { get set}
}
class CreateTodoViewController: UIViewController, CreateTodoView {
    
    
    var presenter: CreateTodoPresenter?
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .white
        label.text = "Create a new todo item"
        label.textAlignment = .center
        return label
    }()
    
    private let itemTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 24)
        textField.backgroundColor = .white
        return textField
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create item", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.backgroundColor = .systemGreen
        
        button.addTarget(self, action: #selector(createItemPressed), for: .touchUpInside)
        
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureUI()
    }
    // MARK: - Selectors
    
    @objc func createItemPressed() {
        guard let todotext = itemTextField.text, !todotext.isEmpty else {
            print("Todo text is empty")
            return
        }
        presenter?.uploadTodoItem(text: todotext)
    }
    
    
    func configureUI() {
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(itemTextField)
        itemTextField.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 128, paddingLeft: 16, paddingRight: 16, height: 40)
        itemTextField.delegate = self
        
        view.addSubview(createButton)
        createButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 16, paddingBottom: 32, paddingRight: 16, height: 50)
    }
}

extension CreateTodoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
