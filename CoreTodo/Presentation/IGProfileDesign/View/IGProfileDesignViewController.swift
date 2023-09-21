//
//  IGProfileDesignViewController.swift
//  CoreTodo
//
//  Created by Yujin Kim on 2023-09-14.
//

import SnapKit
import Then
import UIKit

class IGProfileDesignViewController: UIViewController {
    
    weak var coordinator: IGProfileDesignViewCoordinator?
    
    private lazy var userFollowInfoVStackView = UserFollowInfoHStackView()
    
    private lazy var userInfoVStackView = UserInfoVStackView()
    
    private lazy var middleBarHorizontalStackView = MiddleBarHStackView()
    
    private lazy var navigationBarHStackView = NavigationBarHStackView()
    
    private lazy var menuButtonItem = UIBarButtonItem().then({
        $0.image = UIImage(systemName: "ellipsis")
        $0.isEnabled = false
    })
    
    private lazy var userPicture: UIImageView = .init().then({
        $0.frame = .zero
        $0.layer.cornerRadius = CGFloat(44.0)
        $0.clipsToBounds = true
        $0.image = UIImage(named: "MyongE_Skrr_Image")
        $0.contentMode = .scaleAspectFit
    })
    
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
        title = StringLiterals.kUserName
        navigationItem.rightBarButtonItem = menuButtonItem
        setUI()
        setLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParent {
            coordinator?.finish()
        }
    }
}

extension IGProfileDesignViewController: UIViewControllerConfigurable {
    
    func setUI() {
        view.backgroundColor = .white
        view.addSubviews([
            userPicture,
            userFollowInfoVStackView,
            userInfoVStackView,
            middleBarHorizontalStackView,
            navigationBarHStackView,
            photoCollectionView
        ])
    }
    
    func setLayout() {
        userPicture.snp.makeConstraints({ constraint in
            constraint.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            constraint.leading.equalToSuperview().offset(16)
            constraint.width.height.equalTo(88)
        })
        userFollowInfoVStackView.snp.makeConstraints({ constraint in
            constraint.top.equalTo(userPicture)
            constraint.leading.equalTo(userPicture.snp.trailing).offset(60)
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
            constraint.bottom.equalTo(view.safeAreaLayoutGuide)
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
        cell.backgroundColor = UIColor.gray
        
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
