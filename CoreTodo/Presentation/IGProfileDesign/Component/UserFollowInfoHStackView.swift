//
//  UserFollowInfoHStackView.swift
//  CoreTodo
//
//  Created by Yujin Kim on 2023-09-16.
//

import SnapKit
import Then
import UIKit

final class UserFollowInfoHStackView: UIStackView {
    private lazy var postInfoLabel: UILabel = .init().then({
        $0.text = StringLiterals.kPosts
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    })
    
    private lazy var postDataLabel: UILabel = .init().then({
        $0.text = "12"
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    })
    
    private lazy var postVStackView: UIStackView = .init().then({
        $0.axis = .vertical
        $0.spacing = CGFloat(2)
        $0.alignment = .center
    })
    
    private lazy var followerInfoLabel: UILabel = .init().then({
        $0.text = StringLiterals.kFollowers
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    })
    
    private lazy var followerDataLabel: UILabel = .init().then({
        $0.text = "1"
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    })
    
    private lazy var followerVStackView: UIStackView = .init().then({
        $0.axis = .vertical
        $0.spacing = CGFloat(2)
        $0.alignment = .center
    })
    
    private lazy var followingInfoLabel: UILabel = .init().then({
        $0.text = StringLiterals.kFollowing
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    })
    
    private lazy var followingDataLabel: UILabel = .init().then({
        $0.text = "1"
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    })
    
    private lazy var followingVStackView: UIStackView = .init().then({
        $0.axis = .vertical
        $0.spacing = CGFloat(2)
        $0.alignment = .center
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

extension UserFollowInfoHStackView: UIStackViewConfigurable {
    func configure() {
        self.axis = .horizontal
        self.spacing = CGFloat(28)
        self.distribution = .equalSpacing
        self.alignment = .center
    }
    
    func setUI() {
        addArrangedSubviews([postVStackView, followerVStackView, followingVStackView])
        postVStackView.addArrangedSubviews([postDataLabel, postInfoLabel])
        followerVStackView.addArrangedSubviews([followerDataLabel, followerInfoLabel])
        followingVStackView.addArrangedSubviews([followingDataLabel, followingInfoLabel])
    }
}
