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
    
    private lazy var catImageRefreshButton = UIBarButtonItem().then({
        $0.image = UIImage(systemName: "arrow.clockwise")
        $0.style = .plain
        $0.isEnabled = true
    })
    
    private lazy var catImageView = UIImageView().then({
        $0.layer.cornerRadius = CGFloat(16)
        $0.contentMode = .scaleAspectFit
    })
    
    private lazy var testImgeView = UIImageView().then({
        $0.image = UIImage(systemName: "circle.square.fill")
        $0.layer.cornerRadius = CGFloat(16)
        $0.contentMode = .scaleAspectFit
    })
    
    private lazy var tableView = UITableView(frame: .zero, style: .insetGrouped).then({
        $0.isScrollEnabled = false
        $0.backgroundColor = .systemGray6
        $0.rowHeight = 100
        $0.separatorStyle = .singleLine
        $0.layer.cornerRadius = CGFloat(8)
        $0.register(NavigationCell.self, forCellReuseIdentifier: "NavigationCell")
        $0.delegate = self
        $0.dataSource = self
    })
    
    private lazy var gradientLayer = CAAnimationGradientLayer()

    private lazy var ambiantView = UIView().then({
        $0.frame = .zero
        $0.backgroundColor = .clear
        $0.layer.addSublayer(gradientLayer)
        $0.clipsToBounds = true
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "둘러보기"
        setUI()
        setLayout()
        setDelegate()
        addTarget()
    }
    
}

extension HomeViewController: UIViewControllerConfigurable {
    
    func setUI() {
        gradientLayer.frame = view.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.drawsAsynchronously = true
        navigationItem.rightBarButtonItem = catImageRefreshButton
        ambiantView.addSubview(testImgeView)
        view.addSubviews([ambiantView, tableView])
    }
    
    func setLayout() {
        // 고양이 사진 들어갈 자리
        testImgeView.snp.makeConstraints({ constraint in
            constraint.trailing.bottom.equalToSuperview().offset(-8)
            constraint.width.height.equalTo(200)
        })
        ambiantView.snp.makeConstraints({ constraint in
            constraint.top.equalToSuperview()
            constraint.leading.trailing.bottom.equalToSuperview()
            constraint.height.equalToSuperview().multipliedBy(0.4)
        })
        tableView.snp.makeConstraints({ constraint in
            constraint.top.equalTo(ambiantView.snp.bottom)
            constraint.leading.trailing.bottom.equalToSuperview()
            constraint.height.equalToSuperview().multipliedBy(0.6)
        })
    }
    
    func setDelegate() {}
    
    func addTarget() {}
    
}
// MARK: - UITableView Data Source
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NavigationCell", for: indexPath) as? NavigationCell else {
            fatalError("The dequeued cell is not an instance of NavigationCell.")
        }
        if indexPath.row == 0 {
            cell.configure(with: "해야할 일 확인하기")
            return cell
        } else if indexPath.row == 1 {
            cell.configure(with: "완료된 일 확인하기")
            return cell
        } else if indexPath.row == 2 {
            cell.configure(with: "인스타그램")
            return cell
        }
        return cell
    }
    
}
// MARK: - UITableView Delegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            coordinator?.toTaskView()
            print("HomeCoordinator: \(String(describing: coordinator?.childCoordinators))")
        case 1:
            coordinator?.toCompleteView()
            print("HomeCoordinator: \(String(describing: coordinator?.childCoordinators))")
        case 2:
            coordinator?.toIGProfileDesignView()
            print("HomeCoordinator: \(String(describing: coordinator?.childCoordinators))")
        default:
            break
        }
    }
    
}

extension HomeViewController {
    @objc
    private func taskCoverViewTapped(_ view: UIView) {
        coordinator?.toTaskView()
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

struct HomeViewControllerPreviewView: PreviewProvider {
    static var previews: some View {
        let viewController = HomeViewController()
        return UIViewControllerRepresenter(viewController: viewController)
    }
}
#endif
