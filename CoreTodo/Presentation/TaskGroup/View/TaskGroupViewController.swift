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
    
    var viewModel: TaskViewModel?
    
    private var tasks = [Task]()
    
    private lazy var textField = UITextField().then({
        $0.borderStyle = .none
    })
    
    private lazy var createTaskButtonItem = UIBarButtonItem().then({
        $0.image = UIImage(systemName: "square.and.pencil")
        $0.tintColor = UIColor(hex: "#141617")
        $0.style = .plain
        $0.isEnabled = true
    })
    
    private lazy var numberLabel = UILabel().then({
        $0.text = "0개의 항목"
        $0.textColor = UIColor.systemGray
        $0.font = UIFont.systemFont(ofSize: 12)
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
        
        loadTask()
        updateNumberLabel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParent {
            coordinator?.end()
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

extension TaskGroupViewController: UITableViewDataSource, TaskCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfTask() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskCell else {
            fatalError("Failed to dequeue a reusable cell.")
        }
        
        let tasks = viewModel?.loadTask()
        let task = tasks?[indexPath.row]
        
        cell.delegate = self
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
    
    func didToggleCheckboxButton(_ cell: TaskCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let task = tasks[indexPath.row]
            task.isCompleted = true
            
            viewModel?.updateTask(task)
            
            loadTask()
            tableView.reloadData()
        }
    }
    
}

extension TaskGroupViewController {
    
    private func loadTask() {
        if let viewModel = viewModel {
            tasks = viewModel.loadTask()
        }
    }
    
    private func updateNumberLabel() {
        if let number = viewModel?.numberOfTask() {
            numberLabel.text = "\(number)개의 항목"
        } else {
            numberLabel.text = "0개의 항목"
        }
    }
    
    private func taskDidRemoving(at indexPath: IndexPath) {
        viewModel?.deleteTask(at: indexPath.row)
        
        updateNumberLabel()
        
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
}

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
            self?.viewModel?.createTask(title: title)
            self?.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}
