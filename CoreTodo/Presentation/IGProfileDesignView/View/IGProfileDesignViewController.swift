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
    
    private lazy var userPicture: UIImageView = .init().then({
        $0.frame = .zero
        $0.layer.cornerRadius = CGFloat(44.0)
        $0.clipsToBounds = true
        $0.image = UIImage(named: "MyongE_Skrr_Image")
        $0.contentMode = .scaleAspectFit
    })
    
    private lazy var userFollowInfoVStackView = UserFollowInfoHStackView()
    
    private lazy var userInfoVStackView = UserInfoVStackView()
    
    private lazy var middleBarHorizontalStackView = MiddleBarHStackView()
    
    private lazy var navigationBarHStackView = NavigationBarHStackView()
    
    private lazy var photoCollectionViewFlowLayout: UICollectionViewFlowLayout = .init().then({
        $0.minimumLineSpacing = CGFloat(2)
        $0.minimumInteritemSpacing = CGFloat(2)
    })
    
    private lazy var photoCollectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: photoCollectionViewFlowLayout).then({
        $0.backgroundColor = .white
        $0.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseIdentifier)
        $0.dataSource = self
        $0.delegate = self
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
            userInfoVStackView,
            middleBarHorizontalStackView,
            navigationBarHStackView,
            photoCollectionView
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
            constraint.bottomMargin.equalTo(userInfoVStackView.snp.topMargin).offset(-40)
        })
        userFollowInfoVStackView.snp.makeConstraints({ constraint in
            constraint.top.equalTo(usernameLabel.snp.bottom)
            constraint.leadingMargin.equalTo(userPicture.snp.trailingMargin).offset(60)
            constraint.trailingMargin.equalToSuperview().offset(-28)
            constraint.height.equalTo(88)
        })
        userInfoVStackView.snp.makeConstraints({ constraint in
            constraint.topMargin.equalTo(userFollowInfoVStackView.snp.bottom).offset(20)
            constraint.leadingMargin.equalToSuperview()
            constraint.trailingMargin.equalToSuperview()
        })
        middleBarHorizontalStackView.snp.makeConstraints({ constraint in
            constraint.topMargin.equalTo(userInfoVStackView.snp.bottom).offset(16)
            constraint.leadingMargin.trailingMargin.equalToSuperview()
        })
        navigationBarHStackView.snp.makeConstraints({ constraint in
            constraint.top.equalTo(middleBarHorizontalStackView.snp.bottom).offset(8)
            constraint.leading.trailing.equalToSuperview()
            constraint.height.equalTo(50)
        })
        photoCollectionView.snp.makeConstraints({ constraint in
            constraint.top.equalTo(navigationBarHStackView.snp.bottom)
            constraint.leading.trailing.equalToSuperview()
            constraint.bottom.equalToSuperview()
        })
    }
    
    func setDelegate() {}
    
    func addTarget() {}
}

extension IGProfileDesignViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath)
        cell.backgroundColor=UIColor.gray
        
        return cell
    }
}

extension IGProfileDesignViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.size.width - 8) / 3
        let height = width
        
        return CGSize(width: width, height: height)
    }
}

class PhotoCell: UICollectionViewCell {
    static let reuseIdentifier = "PhotoCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
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
