//
//  NavigationBarHStackView.swift
//  CoreTodo
//
//  Created by Yujin Kim on 2023-09-16.
//

import UIKit

final class NavigationBarHStackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NavigationBarHStackView: UIStackViewConfigurable {
    func configure() {
        self.axis = .horizontal
        self.spacing = CGFloat(2)
        self.distribution = .equalSpacing
        self.alignment = .leading
    }
}
