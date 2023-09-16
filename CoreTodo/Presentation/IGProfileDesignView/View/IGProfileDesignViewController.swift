//
//  IGProfileDesignViewController.swift
//  CoreTodo
//
//  Created by Yujin Kim on 2023-09-14.
//

import SnapKit
import Then
import UIKit

final class IGProfileDesignViewController: UIViewController {
    private lazy var usernameLabel: UILabel = .init().then({
        $0.text = StringLiterals.kUserName
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    })
    
    private lazy var menu: UIImageView = .init().then({
        $0.frame = .zero
        $0.clipsToBounds = true
        $0.image = UIImage(named: "Three_Dots_Image")
        $0.contentMode = .scaleAspectFit
    })
    
    private lazy var middleBarHorizontalStackView = MiddleBarHorizontalStackView()
    
    private lazy var userPicture: UIImageView = .init().then({
        $0.frame = .zero
        $0.layer.cornerRadius = CGFloat(44.0)
        $0.clipsToBounds = true
        $0.image = UIImage(named: "MyongE_Skrr_Image")
        $0.contentMode = .scaleAspectFit
    })
    
    private lazy var userFollowInfoVStackView = UserFollowInfoHStackView()
    
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
}

extension IGProfileDesignViewController: UIViewControllerConfigurable {
    func setUI() {
        view.backgroundColor = .white
        view.addSubviews([
            usernameLabel,
            menu,
            userPicture,
            userFollowInfoVStackView,
            userInfoVerticalStackView,
            middleBarHorizontalStackView
        ])
    }
    
    func setLayout() {
        usernameLabel.snp.makeConstraints({ constraint in
            constraint.top.equalToSuperview()
            constraint.centerX.equalToSuperview()
            constraint.height.equalTo(30)
        })
        menu.snp.makeConstraints({ constraint in
            constraint.top.equalToSuperview()
            constraint.trailingMargin.equalToSuperview()
            constraint.width.equalTo(60)
            constraint.height.equalTo(30)
            constraint.leading.equalTo(usernameLabel.snp.trailing).offset(20)
        })
        userPicture.snp.makeConstraints({ constraint in
            constraint.top.equalTo(usernameLabel.snp.bottom)
            constraint.leadingMargin.equalToSuperview()
            constraint.width.height.equalTo(88)
            constraint.bottomMargin.equalTo(userInfoVerticalStackView.snp.topMargin).offset(-40)
        })
        userFollowInfoVStackView.snp.makeConstraints({ constraint in
            constraint.top.equalTo(usernameLabel.snp.bottom)
            constraint.leadingMargin.equalTo(userPicture.snp.trailingMargin).offset(60)
            constraint.trailingMargin.equalToSuperview().offset(-28)
            constraint.height.equalTo(88)
        })
        userInfoVerticalStackView.snp.makeConstraints({ constraint in
            constraint.topMargin.equalTo(userFollowInfoVStackView.snp.bottom).offset(20)
            constraint.leadingMargin.equalToSuperview()
            constraint.trailingMargin.equalToSuperview()
        })
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
