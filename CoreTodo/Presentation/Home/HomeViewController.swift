//
//  HomeViewController.swift
//  CoreTodo
//
//  Created by Yujin Kim on 2023-09-19.
//

import SnapKit
import Then
import UIKit

class HomeViewController: UIViewController {
    
    weak var coordinator: HomeViewCoordinator?
    
    private lazy var homeViewLabel: UILabel = .init().then({
        $0.text = "홈 화면"
        $0.font = UIFont.systemFont(ofSize: 22)
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
}

extension HomeViewController: UIViewControllerConfigurable {
    
    func setUI() {
        view.addSubview(homeViewLabel)
    }
    
    func setLayout() {
        homeViewLabel.snp.makeConstraints({ constraint in
            constraint.centerX.equalToSuperview()
            constraint.centerY.equalToSuperview()
        })
    }
    
    func setDelegate() {}
    
    func addTarget() {}
    
}
