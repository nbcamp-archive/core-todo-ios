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
    
    var taskViewModel: TaskViewModel?
    
    private lazy var textField = UITextField().then({
        $0.borderStyle = .none
    })
    
    private lazy var createTaskButtonItem: UIBarButtonItem = .init().then({
        $0.image = UIImage(systemName: "square.and.pencil")
        $0.tintColor = UIColor(hex: "#141617")
        $0.style = .plain
        $0.isEnabled = true
    })
    
    private lazy var numberLabel = UILabel().then({
        $0.text = "0개의 항목"
        $0.textColor = UIColor.systemGray
        $0.font = UIFont.systemFont(ofSize: 10)
    })
    
    private lazy var tableView = UITableView().then({
        $0.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
        $0.backgroundColor = .systemGray6
        $0.rowHeight = 80
        $0.separatorStyle = .singleLine
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setDelegate()
        addTarget()
        updateNumberLabel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParent {
            coordinator?.finish()
        }
    }
    
}

extension TaskGroupViewController: UIViewControllerConfigurable {
    
    func setUI() {
        navigationItem.rightBarButtonItem = createTaskButtonItem
        view.addSubviews([tableView, numberLabel])
    }
    
    func setLayout() {
        tableView.snp.makeConstraints({ constraint in
            constraint.leading.trailing.equalToSuperview()
            constraint.top.bottom.equalToSuperview()
        })
        numberLabel.snp.makeConstraints({ constraint in
            constraint.centerX.equalToSuperview()
            constraint.bottom.equalTo(view.safeAreaLayoutGuide)
        })
    }
    
    func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func addTarget() {
        createTaskButtonItem.target = self
        createTaskButtonItem.action = #selector(createTaskButtonTapped(_:))
    }
    
}

extension TaskGroupViewController: UITableViewDelegate {
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
    }
    
}

extension TaskGroupViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskViewModel?.numberOfTask() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskCell else {
            fatalError("Failed to dequeue a reusable cell.")
        }
        
        let tasks = taskViewModel?.loadTask()
        let task = tasks?[indexPath.row]
        cell.configure(with: task!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { [weak self] (_, _, completion) in
            self?.taskDidRemoving(at: indexPath)
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}

extension TaskGroupViewController {
    
    private func updateNumberLabel() {
        if let number = taskViewModel?.numberOfTask() {
            numberLabel.text = "\(number)개의 항목"
        } else {
            numberLabel.text = "0개의 항목"
        }
    }
    
    private func taskDidRemoving(at indexPath: IndexPath) {
        taskViewModel?.deleteTask(at: indexPath.row)
        
        updateNumberLabel()
        
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
}
// MARK: - 커스텀 메서드
extension TaskGroupViewController {
    
    @objc
    private func createTaskButtonTapped(_ button: UIBarButtonItem) {
        let alertController = UIAlertController(title: "새로운 할 일 추가", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "내용"
        }
        
        let saveAction = UIAlertAction(title: "저장", style: .default) { [weak self] _ in
            guard let title = alertController.textFields?.first?.text, !title.isEmpty else {
                return
            }
            self?.taskViewModel?.createTask(title: title)
            self?.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}
