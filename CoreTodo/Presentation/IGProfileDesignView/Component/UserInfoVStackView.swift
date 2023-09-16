//
//  UserInfoVStackView.swift
//  CoreTodo
//
//  Created by Yujin Kim on 2023-09-16.
//

import SnapKit
import Then
import UIKit

final class UserInfoVStackView: UIStackView {
    
    private lazy var nameLabel: UILabel = .init().then({
        $0.text = StringLiterals.kName
        $0.font = UIFont.boldSystemFont(ofSize: 14.0)
    })
    
    private lazy var bioLabel: UILabel = .init().then({
        $0.text = StringLiterals.kBio
        $0.font = UIFont.systemFont(ofSize: 14.0)
    })
    
    private lazy var linkInbioLabel: UILabel = .init().then({
        $0.text = StringLiterals.kLinkToBio
        $0.textColor = .systemBlue
        $0.font = UIFont.systemFont(ofSize: 14.0)
    })
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setUI()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UserInfoVStackView: UIStackViewConfigurable {
    func configure() {
        self.axis = .vertical
        self.spacing = CGFloat(2)
        self.alignment = .leading
    }
    
    func setUI() {
        addArrangedSubviews([nameLabel, bioLabel, linkInbioLabel])
    }
}
