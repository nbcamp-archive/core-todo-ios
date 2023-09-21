//
//  TaskCell.swift
//  CoreTodo
//
//  Created by Yujin Kim on 2023-09-21.
//

import SnapKit
import Then
import UIKit

class TaskCell: UITableViewCell {
    
    static let reuseIdentifier = "TaskCell"
    
    private lazy var checkboxButton = UIButton().then({
        $0.setImage(UIImage(systemName: "circle"), for: .normal)
        $0.setImage(UIImage(systemName: "checkmark.circle.fil"), for: .selected)
        $0.tintColor = UIColor.systemGray4
    })
    
    private lazy var titleLabel = UILabel().then({
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = UIColor(hex: "#141617")
    })
    
    private lazy var createDateLabel = UILabel().then({
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.textColor = UIColor.systemGray4
        $0.numberOfLines = 1
    })
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
        addTarget()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with task: Task) {
        titleLabel.text = task.title
        if let createDate = task.createDate {
            createDateLabel.text = "\(createDate)"
        } else {
            createDateLabel.text = ""
        }
    }
    
    func setUI() {
        contentView.addSubviews([checkboxButton, titleLabel, createDateLabel])
    }
    
    func setLayout() {
        checkboxButton.snp.makeConstraints({ constraint in
            constraint.leading.equalToSuperview().offset(16)
            constraint.centerY.equalToSuperview()
        })
        titleLabel.snp.makeConstraints({ constraint in
            constraint.leading.equalTo(checkboxButton.snp.trailing).offset(16)
            constraint.centerY.equalTo(checkboxButton)
        })
        createDateLabel.snp.makeConstraints({ constraint in
            constraint.leading.equalTo(titleLabel)
            constraint.bottom.equalToSuperview()
        })
    }
    
    func addTarget() {
        checkboxButton.addTarget(self, action: #selector(checkboxButtonTapped(_:)), for: .touchUpInside)
    }
}

extension TaskCell {
    
    @objc
    private func checkboxButtonTapped(_ button: UIButton) {
        checkboxButton.isSelected.toggle()
    }
    
}
