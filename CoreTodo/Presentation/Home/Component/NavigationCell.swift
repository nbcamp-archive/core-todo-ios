//
//  NavigationCell.swift
//  CoreTodo
//
//  Created by Yujin Kim on 2023-09-20.
//

import SnapKit
import Then
import UIKit

class NavigationCell: UITableViewCell {
    
    static let reuseIdentifier: String = "NavigationCell"
    
    private lazy var titleLabel = UILabel().then({
        $0.font = UIFont.boldSystemFont(ofSize: 22)
        $0.textColor = UIColor(hex: "#141617")
        $0.numberOfLines = 1
    })
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String) {
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    func setUI() {
        accessoryType = .disclosureIndicator
        contentView.addSubview(titleLabel)
        contentView.clipsToBounds = true
    }
    
    func setLayout() {
        titleLabel.snp.makeConstraints({ constraint in
            constraint.leading.equalToSuperview().offset(8)
            constraint.centerY.equalToSuperview()
        })
    }
    
}
