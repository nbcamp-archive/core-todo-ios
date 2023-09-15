//
//  UIView+AddSubviews.swift
//  CoreTodo
//
//  Created by Yujin Kim on 2023-09-15.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach({ view in
            self.addSubview(view)
        })
    }
}
