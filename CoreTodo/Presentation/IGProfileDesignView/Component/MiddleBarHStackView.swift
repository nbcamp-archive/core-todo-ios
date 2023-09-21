//
//  MiddleBarHorizontalStackView.swift
//  CoreTodo
//
//  Created by Yujin Kim on 2023-09-15.
//

import SnapKit
import Then
import UIKit

final class MiddleBarHStackView: UIStackView {
    private lazy var followFillButton: UIButton = .init(type: .system).then({
        $0.layer.cornerRadius = CGFloat(8)
        $0.clipsToBounds = true
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        $0.setTitle(StringLiterals.kFollowFillButton, for: .normal)
        $0.backgroundColor = UIColor(hex: "#4192EF")
        $0.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        $0.setTitleColor(UIColor(hex: "#FFFFFF"), for: .highlighted)
    })
    
    private lazy var messageFillButton: UIButton = .init(type: .system).then({
        $0.layer.cornerRadius = CGFloat(8)
        $0.clipsToBounds = true
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        $0.setTitle(StringLiterals.kMessageFillButton, for: .normal)
        $0.backgroundColor = .systemGray6
        $0.setTitleColor(UIColor(hex: "#000000"), for: .normal)
        $0.setTitleColor(UIColor(hex: "#000000"), for: .highlighted)
    })
    
    private lazy var findUserFillButton: UIButton = .init(type: .system).then({
        $0.layer.cornerRadius = CGFloat(8)
        $0.clipsToBounds = true
        $0.backgroundColor = .systemGray6
        $0.setImage(UIImage(systemName: "person.badge.plus"), for: .normal)
    })
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MiddleBarHStackView: UIStackViewConfigurable {
    func configure() {
        self.axis = .horizontal
        self.spacing = CGFloat(4)
        self.alignment = .leading
        self.backgroundColor = .red
        addArrangedSubviews([followFillButton, messageFillButton, findUserFillButton])
        setLayout()
    }
    
    func setLayout() {
        followFillButton.snp.makeConstraints({ constraint in
            constraint.width.equalTo(150)
            constraint.bottom.equalToSuperview()
        })
        messageFillButton.snp.makeConstraints({ constraint in
            constraint.width.equalTo(followFillButton.snp.width)
            constraint.leading.equalTo(followFillButton.snp.trailing).offset(4)
            constraint.bottom.equalToSuperview()
        })
        findUserFillButton.snp.makeConstraints({ constraint in
            constraint.width.height.equalTo(30)
            constraint.leading.equalTo(messageFillButton.snp.trailing).offset(4)
        })
    }
}
