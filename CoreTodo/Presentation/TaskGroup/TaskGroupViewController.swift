//
//  TaskGroupViewController.swift
//  CoreTodo
//
//  Created by Yujin Kim on 2023-09-20.
//

import SnapKit
import Then
import UIKit

class TaskGroupViewController: UIViewController {
    
    weak var coordinator: TaskGroupViewCoordinator?
    
    private lazy var createTaskButtonItem: UIBarButtonItem = .init().then({
        $0.image = UIImage(systemName: "square.and.pencil")
        $0.style = .plain
        $0.isEnabled = true
    })
    
    private lazy var taskTableView: UITableView = .init(frame: .zero, style: .insetGrouped).then({
        $0.rowHeight = 80
        $0.separatorStyle = .none
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setDelegate()
        addTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setToolbarHidden(true, animated: animated)
    }
}

extension TaskGroupViewController: UIViewControllerConfigurable {
    
    func setUI() {
        self.setToolbarItems([.flexibleSpace(), createTaskButtonItem], animated: false)
        view.addSubviews([taskTableView])
    }
    
    func setLayout() {}
    
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

struct TaskGroupViewControllerPreviewView: PreviewProvider {
    static var previews: some View {
        let viewController = TaskGroupViewController()
        return UIViewControllerRepresenter(viewController: viewController)
    }
}
#endif
