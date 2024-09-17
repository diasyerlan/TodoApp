//
//  TodoCell.swift
//  TodoApp
//
//  Created by Dias Yerlan on 11.09.2024.
//

import Foundation
import UIKit

class TodoCell: UITableViewCell {
    
    var todoItem: TodoItem? {
        didSet {
            titleLabel.text = todoItem?.title
            if let status = todoItem?.isComplete, status {
                statusLabel.text = "Complete"
                statusLabel.textColor = .systemGreen
            } else {
                statusLabel.text = "Incomplete"
                statusLabel.textColor = .systemRed
            }
        }
    }
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.text = "Title label"
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        label.text = "Incomplete"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(red: 30/255, green: 33/255, blue: 43/255, alpha: 1.0)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 4, paddingLeft: 8)
        
        addSubview(statusLabel)
        statusLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, paddingTop: 4, paddingLeft: 8)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
