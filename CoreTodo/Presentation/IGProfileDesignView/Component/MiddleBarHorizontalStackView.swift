//
//  MiddleBarHorizontalStackView.swift
//  CoreTodo
//
//  Created by Yujin Kim on 2023-09-15.
//

import SnapKit
import Then
import UIKit

final class MiddleBarHorizontalStackView: UIStackView, UIStackViewConfigurable {
    
    private lazy var followFillButton: UIButton = .init(type: .custom).then({
        $0.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        $0.layer.cornerRadius = CGFloat(8)
        $0.clipsToBounds = true
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        $0.setTitle("팔로우", for: .normal)
        $0.backgroundColor = .systemBlue
        $0.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        $0.setTitleColor(UIColor(hex: "#000000"), for: .highlighted)
    })
    
    private lazy var messageFillButton: UIButton = .init(type: .custom).then({
        $0.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        $0.layer.cornerRadius = CGFloat(8)
        $0.clipsToBounds = true
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        $0.setTitle("메시지", for: .normal)
        $0.backgroundColor = .systemGray6
        $0.setTitleColor(UIColor(hex: "#000000"), for: .normal)
        $0.setTitleColor(UIColor(hex: "#000000"), for: .highlighted)
    })
    
    private lazy var findUserFillButton: UIButton = .init(type: .custom).then({
        $0.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        $0.layer.cornerRadius = CGFloat(8)
        $0.clipsToBounds = true
        $0.backgroundColor = .systemGray6
        $0.setTitle("0", for: .normal)
    })
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        axis = .horizontal
        spacing = CGFloat(4)
        alignment = .leading
        addArrangedSubviews([followFillButton, messageFillButton, findUserFillButton])
    }
}
