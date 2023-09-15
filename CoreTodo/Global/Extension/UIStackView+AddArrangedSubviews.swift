//
//  UIStackView+AddArrangedSubviews.swift
//  CoreTodo
//
//  Created by Yujin Kim on 2023-09-15.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach({ view in
            self.addArrangedSubview(view)
        })
    }
}
