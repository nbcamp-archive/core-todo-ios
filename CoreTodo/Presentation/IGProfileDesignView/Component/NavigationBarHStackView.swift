//
//  NavigationBarHStackView.swift
//  CoreTodo
//
//  Created by Yujin Kim on 2023-09-16.
//

import UIKit

final class NavigationBarHStackView: UIStackView {
    private lazy var gridImageView: UIImageView = .init().then({
        $0.image = UIImage(named: "Grid_Image")?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = .black
        $0.contentMode = .scaleAspectFit
    })
    
    private lazy var reelsImageView: UIImageView = .init().then({
        $0.image = UIImage(named: "Reels_Image")?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = .gray
        $0.contentMode = .scaleAspectFit
    })
    
    private lazy var tagImageView: UIImageView = .init().then({
        $0.image = UIImage(named: "Tagged_Image")?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = .gray
        $0.contentMode = .scaleAspectFit
    })
    
    private lazy var indicatorView: UIView = .init().then({
        $0.backgroundColor = UIColor.black
    })
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setUI()
        setLayout()
        setGestureRecognizer()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NavigationBarHStackView: UIStackViewConfigurable {
    func configure() {
        self.axis = .horizontal
        self.spacing = CGFloat(16)
        self.distribution = .equalSpacing
        self.alignment = .center
    }
    
    func setUI() {
        addArrangedSubviews([gridImageView, reelsImageView, tagImageView])
        addSubview(indicatorView)
    }
    
    func setLayout() {
        gridImageView.snp.makeConstraints({ constraint in
            constraint.width.equalTo(130)
            constraint.height.equalTo(26)
        })
        
        reelsImageView.snp.makeConstraints({ constraint in
            constraint.width.equalTo(gridImageView.snp.width)
            constraint.height.equalTo(gridImageView.snp.height)
        })
        
        tagImageView.snp.makeConstraints({ constraint in
            constraint.width.equalTo(gridImageView.snp.width)
            constraint.height.equalTo(gridImageView.snp.height)
        })
        
        indicatorView.snp.makeConstraints({ constraint in
            constraint.bottom.equalToSuperview()
            constraint.height.equalTo(2)
            constraint.width.centerX.equalTo(gridImageView)
        })
    }
    
    func setGestureRecognizer() {
        let gridTapGestureRecognizer = UITapGestureRecognizer()
        gridTapGestureRecognizer.addTarget(self, action: #selector(gridImageViewTapped(_:)))
        gridImageView.isUserInteractionEnabled = true
        gridImageView.addGestureRecognizer(gridTapGestureRecognizer)
        
        let reelsTapGestureRecognizer = UITapGestureRecognizer()
        reelsTapGestureRecognizer.addTarget(self, action: #selector(reelsImageViewTapped(_:)))
        reelsImageView.isUserInteractionEnabled = true
        reelsImageView.addGestureRecognizer(reelsTapGestureRecognizer)
        
        let tagTapGestureRecognizer = UITapGestureRecognizer()
        tagTapGestureRecognizer.addTarget(self, action: #selector(tagImageViewTapped(_:)))
        tagImageView.isUserInteractionEnabled = true
        tagImageView.addGestureRecognizer(tagTapGestureRecognizer)
    }
}

extension NavigationBarHStackView {
    @objc
    private func gridImageViewTapped(_ button: UIButton) {
        moveIndicator(to: gridImageView)
        selectedColor(gridImageView)
    }
    
    @objc
    private func reelsImageViewTapped(_ button: UIButton) {
        moveIndicator(to: reelsImageView)
        selectedColor(reelsImageView)
    }
    
    @objc
    private func tagImageViewTapped(_ button: UIButton) {
        moveIndicator(to: tagImageView)
        selectedColor(tagImageView)
    }
}

extension NavigationBarHStackView {
    private func moveIndicator(to view: UIImageView) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let position = self else { return }
            position.indicatorView.snp.remakeConstraints({ constraint in
                constraint.bottom.equalToSuperview()
                constraint.height.equalTo(2)
                constraint.width.centerX.equalTo(view)
            })
            position.layoutIfNeeded()
        }
    }
    private func selectedColor(_ imageView: UIImageView) {
        let views = [gridImageView, reelsImageView, tagImageView]
        
        views.forEach({ view in
            view.tintColor = (view == imageView) ? .black : .gray
        })
    }
}
