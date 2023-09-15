//
//  IGProfileDesignViewController.swift
//  CoreTodo
//
//  Created by Yujin Kim on 2023-09-14.
//

import SnapKit
import Then
import UIKit

final class IGProfileDesignViewController: UIViewController, UIViewControllerConfigurable {
    // MARK: UI 컴포넌트
    private lazy var usernameLabel: UILabel = .init().then({
        $0.text = StringLiterals.kUserName
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    })
    
    private lazy var hamburgerMenu: UIImageView = .init(image: UIImage(named: ""))
    
    private lazy var middleBarHorizontalStackView = MiddleBarHorizontalStackView()
    
    private lazy var userPictureView: UIView = .init().then({
        $0.frame = CGRect(x: 0, y: 0, width: 88, height: 88)
        $0.layer.cornerRadius = CGFloat(44.0)
        $0.clipsToBounds = true
        $0.backgroundColor = .red
    })
    
    private lazy var userPicture: UIImageView = .init().then({
        $0.frame = CGRect(x: 0, y: 0, width: 88, height: 88)
        $0.layer.cornerRadius = CGFloat(44.0)
        $0.clipsToBounds = true
        $0.image = UIImage(named: "MyongE_Skrr_Image")
        $0.contentMode = .scaleAspectFit
    })
    
    private lazy var userFollowHorizontalStackView: UIStackView = .init(arrangedSubviews: [
        userPictureView,
        postLabel,
        followerLabel,
        followingLabel
    ]).then({
        $0.axis = .horizontal
        $0.spacing = CGFloat(28)
        $0.alignment = .leading
    })
    
    private lazy var userFollowVerticalStackView: UIStackView = .init(arrangedSubviews: [
        
    ]).then({
        $0.axis = .vertical
        $0.spacing = CGFloat(2)
        $0.alignment = .center
    })
    
    private lazy var postLabel: UILabel = .init().then({
        $0.text = StringLiterals.kPosts
    })
    
    private lazy var followerLabel: UILabel = .init().then({
        $0.text = StringLiterals.kFollowers
    })
    
    private lazy var followingLabel: UILabel = .init().then({
        $0.text = StringLiterals.kFollowing
    })
    
    private lazy var userInfoVerticalStackView: UIStackView = .init(arrangedSubviews: [
        nameLabel,
        bioLabel,
        linkInbioLabel
    ]).then({
        $0.axis = .vertical
        $0.spacing = CGFloat(2)
        $0.alignment = .leading
    })
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    func setUI() {
        title = "username"
        view.backgroundColor = .white
        view.addSubviews([
            usernameLabel,
            userFollowHorizontalStackView,
            userInfoVerticalStackView,
            middleBarHorizontalStackView
        ])
    }
    
    func setLayout() {
        usernameLabel.snp.makeConstraints { constraint in
            constraint.top.equalToSuperview()
            constraint.leading.trailing.equalToSuperview()
        }
        userFollowHorizontalStackView.snp.makeConstraints { constraint in
            constraint.top.equalTo(usernameLabel.snp.bottom)
            constraint.leading.leadingMargin.equalToSuperview()
        }
        userInfoVerticalStackView.snp.makeConstraints { constraint in
            constraint.topMargin.equalTo(userFollowHorizontalStackView.snp.bottom)
            constraint.leadingMargin.equalToSuperview()
            constraint.trailingMargin.equalToSuperview()
        }
        middleBarHorizontalStackView.snp.makeConstraints({ constraint in
            constraint.topMargin.equalTo(userInfoVerticalStackView.snp.bottom).offset(16)
            constraint.leadingMargin.trailingMargin.equalToSuperview()
        })
    }
    
    func setDelegate() {}
    
    func addTarget() {}
}

#if DEBUG && canImport(SwiftUI)
import SwiftUI
private struct UIViewControllerRepresenter: UIViewControllerRepresentable {
    let viewController: UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct UIViewControllerPreviewView: PreviewProvider {
    static var previews: some View {
        let viewController = IGProfileDesignViewController()
        return UIViewControllerRepresenter(viewController: viewController)
    }
}
#endif
